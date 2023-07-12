import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/ui/support_and_service/my_tickets/model/tiicket_model.dart';

part 'my_tickets_state.freezed.dart';

@freezed
class MyTicketsState with _$MyTicketsState {
  const factory MyTicketsState({
    required int ticketStatusIndex,
    required AsyncValue<List<TicketModel>> myTicketList,
    required List<TicketModel> ticketListSelect,
    required List<TicketModel> searchTicketListSelect,
  }) = _MyTicketsState;

  factory MyTicketsState.initial() => const MyTicketsState(
        ticketStatusIndex: 0,
        myTicketList: AsyncLoading(),
        ticketListSelect: [],
        searchTicketListSelect: [],
      );
}
