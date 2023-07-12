import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/ui/support_and_service/my_tickets/model/tiicket_model.dart';
import 'package:pif_flutter/ui/support_and_service/my_tickets/state/my_tickets_state.dart';

final myTicketsProvider = StateNotifierProvider.autoDispose<MyTicketsNotifier, MyTicketsState>((ref) {
  return MyTicketsNotifier(ref: ref);
});

class MyTicketsNotifier extends StateNotifier<MyTicketsState> {
  MyTicketsNotifier({required this.ref}) : super(MyTicketsState.initial()) {
    _initData();
  }

  final searchController = TextEditingController();

  final Ref ref;
  final ticketsStatusList = [
    'All',
    'Pending',
    'In Progress',
    'Closed',
  ];

  void _initData() {
    getMyTickets();
  }

  Future<void> getMyTickets() async {
    var myTicketsList = <TicketModel>[];
    myTicketsList = List.generate(
      20,
      (index) => TicketModel(
        ticketDescription:
            'Issue description Issue ${index + 1} description Issue description  Issue descriptionIssue description  Issue descriptionIssue description  Issue descriptionIssue description  Issue description ',
        ticketStatus: index.isEven
            ? TicketStatusEnum.InProgress
            : TicketStatusEnum.Pending,
        ticketStart: DateTime.now(),
        countMessage: index,
        attachment: 'https://picsum.photos/200/300',
      ),
    );
    state = state.copyWith(myTicketList: AsyncData(myTicketsList));
    updateSelectTicketStatus(indexNewSelect: 0);
  }

  void onSearchTicket() {
    if (searchController.text.isNotEmpty) {
      state = state.copyWith(
        ticketListSelect: state.myTicketList.value!
            .where(
              (ticket) => ticket.ticketDescription.toLowerCase().contains(
                    searchController.text.toLowerCase(),
                  ),
            )
            .toList(),
      );
    } else {
      state = state.copyWith(ticketListSelect: state.myTicketList.value!);
    }
  }

  void updateSelectTicketStatus({required int indexNewSelect}) {
    state = state.copyWith(
      ticketListSelect: getListTicket(newIndexSelect: indexNewSelect),
    );
    state = state.copyWith(ticketStatusIndex: indexNewSelect);
  }

  List<TicketModel> getListTicket({required int newIndexSelect}) {
    switch (newIndexSelect) {
      case 0:
        return state.myTicketList.value ?? [];
      case 1:
        return state.myTicketList.value!
            .where((ticket) => ticket.ticketStatus == TicketStatusEnum.Pending)
            .toList();
      case 2:
        return state.myTicketList.value!
            .where(
              (ticket) => ticket.ticketStatus == TicketStatusEnum.InProgress,
            )
            .toList();
      case 3:
        return state.myTicketList.value!
            .where((ticket) => ticket.ticketStatus == TicketStatusEnum.Closed)
            .toList();
      default:
        return state.myTicketList.value ?? [];
    }
  }
}
