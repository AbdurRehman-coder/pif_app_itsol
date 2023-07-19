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

  final Ref ref;
  late TextEditingController searchController;
  late ScrollController scrollController;
  int? page = 1;
  int? lastPage = 1;

  void _initData() {
    searchController = TextEditingController();
    scrollController = ScrollController();
    scrollController.addListener(loadMore);
    getStatusAsync();
  }

  void loadMore() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      state = state.copyWith(isLoading: true);
      final param = ParametersModel();
      if (state.selectedStatus!.key != 'all') {
        param.filter = FilterUtils.filterBy(
          key: 'ticketStatus',
          value: "'${state.selectedStatus!.key}'",
          operator: FilterOperator.equal.value,
        );
      }
      getMyTickets(pram: param);
    }
  }

  Future<void> getStatusAsync() async {
    final result = await DixelsSDK.instance.supportService.getStatusAsync();
    if (result != null) {
      final lstData = result.listTypeEntries!;
      lstData.insert(0, StatusModel(name: 'All', key: 'all'));

      state = state.copyWith(lstStatus: lstData);
      state = state.copyWith(selectedStatus: state.lstStatus.first);
      updateStatusData(model: state.selectedStatus!);
    }
  }

  Future<void> getMyTickets({ParametersModel? pram}) async {
    if (searchController.text.isEmpty) {
      if (lastPage! < page!) {
        state = state.copyWith(isLoading: false);
        return;
      }
    }

    pram ??= ParametersModel();
    pram.page = searchController.text.isNotEmpty ? 0.toString() : page.toString();
    final result = await DixelsSDK.instance.supportService
        .getPageData(fromJson: SupportTicketModel.fromJson, params: pram);
    if (result != null) {
      lastPage = result.lastPage;
      page = page! + 1;

      final listData = state.lstData.value != null ? state.lstData.value!.toList() : <SupportTicketModel>[];
      listData.addAll(result.items!);
      state = state.copyWith(lstData: AsyncData(listData));
    }
  }

  void onSearchTicket(String searchText) {
    if (searchText.isNotEmpty) {
      state = state.copyWith(lstData: const AsyncLoading());
      final data = "'$searchText'";
      final param = ParametersModel();
      param.filter = 'contains(description,$data)';
      getMyTickets(pram: param);
    } else {
      onFilterData();
    }
  }

  void onFilterData() {
    page = 1;
    state = state.copyWith(lstData: const AsyncLoading());
    final param = ParametersModel();
    if (state.selectedStatus!.key != 'all') {
      param.filter = FilterUtils.filterBy(
        key: 'ticketStatus',
        value: "'${state.selectedStatus!.key}'",
        operator: FilterOperator.equal.value,
      );
    }
    getMyTickets(pram: param);
  }

  void updateStatusData({required StatusModel model}) {
    state = state.copyWith(
      selectedStatus: model,
    );

    for (final element in state.lstStatus) {
      element.isSelected = state.selectedStatus!.key == element.key;
    }
    state = state.copyWith(lstStatus: state.lstStatus);
    onFilterData();
  }

  @override
  void dispose() {
    searchController.dispose();
    scrollController.dispose();
    super.dispose();
  }
}
