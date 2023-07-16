import 'package:dixels_sdk/features/commerce/tickets/model/ticket_comment_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pif_flutter/ui/support_and_service/ticket_details/model/comment_model.dart';

part 'ticket_details_state.freezed.dart';

@freezed
class TicketDetailsState with _$TicketDetailsState {
  const factory TicketDetailsState({
    required List<TicketCommentModel> lstComments,
  }) = _SupportDetailsState;

  factory TicketDetailsState.initial() => const TicketDetailsState(
        lstComments: <TicketCommentModel>[],
      );
}
