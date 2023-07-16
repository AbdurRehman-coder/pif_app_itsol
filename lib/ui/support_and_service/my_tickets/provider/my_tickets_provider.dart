import 'package:dixels_sdk/common/models/parameters_model.dart';
import 'package:dixels_sdk/dixels_sdk.dart';
import 'package:dixels_sdk/features/commerce/support/model/status_model.dart';
import 'package:dixels_sdk/features/commerce/support/model/support_ticket_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/helpers/filter_utils.dart';
import 'package:pif_flutter/ui/support_and_service/my_tickets/state/my_tickets_state.dart';

final myTicketsProvider = StateNotifierProvider.autoDispose<MyTicketsNotifier, MyTicketsState>((ref) {
  return MyTicketsNotifier(ref: ref);
});

class MyTicketsNotifier extends StateNotifier<MyTicketsState> {
  MyTicketsNotifier({required this.ref}) : super(MyTicketsState.initial()) {
    _initData();
  }

  late TextEditingController searchController;
  final Ref ref;

  void _initData() {
    searchController = TextEditingController();
    getStatusAsync();
  }

  Future<void> getStatusAsync() async {
    final result = await DixelsSDK.instance.supportService.getStatusAsync();
    if (result != null) {
      final lstData = result.listTypeEntries!;
      lstData.insert(0, StatusModel(name: 'All', key: 'all'));

      state = state.copyWith(lstStatus: lstData);
      state = state.copyWith(selectedStatus: state.lstStatus.first);
      updateStatusData(model: state.selectedStatus!);
      await getMyTickets();
    }
  }

  Future<void> getMyTickets() async {
    final param = ParametersModel();
    if (state.selectedStatus!.key != 'all') {
      param.filter = FilterUtils.filterBy(
        key: 'ticketStatus',
        value: "'${state.selectedStatus!.key}'",
        operator: FilterOperator.equal.value,
      );
    }
    final result = await DixelsSDK.instance.supportService
        .getPageData(fromJson: SupportTicketModel.fromJson, params: param);
    if (result != null) {
      state = state.copyWith(lstData: AsyncData(result.items!));
    }
  }

  void onSearchTicket() {
    // if (searchController.text.isNotEmpty) {
    //   state = state.copyWith(
    //     ticketListSelect: state.myTicketList.value!
    //         .where(
    //           (ticket) => ticket.ticketDescription.toLowerCase().contains(
    //                 searchController.text.toLowerCase(),
    //               ),
    //         )
    //         .toList(),
    //   );
    // } else {
    //   state = state.copyWith(ticketListSelect: state.myTicketList.value!);
    // }
  }

  void updateStatusData({required StatusModel model}) {
    state = state.copyWith(
      selectedStatus: model,
    );

    for (final element in state.lstStatus) {
      element.isSelected = state.selectedStatus!.key == element.key;
    }
    state = state.copyWith(lstStatus: state.lstStatus);
    getMyTickets();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
