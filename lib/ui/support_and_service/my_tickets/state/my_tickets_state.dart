import 'package:dixels_sdk/features/commerce/support/model/status_model.dart';
import 'package:dixels_sdk/features/commerce/support/model/support_ticket_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'my_tickets_state.freezed.dart';

@freezed
class MyTicketsState with _$MyTicketsState {
  const factory MyTicketsState({
    required StatusModel? selectedStatus,
    required AsyncValue<List<SupportTicketModel>> lstData,
    required List<StatusModel> lstStatus,
  }) = _MyTicketsState;

  factory MyTicketsState.initial() => const MyTicketsState(
        selectedStatus: null,
        lstData: AsyncLoading(),
        lstStatus: <StatusModel>[],
      );
}
