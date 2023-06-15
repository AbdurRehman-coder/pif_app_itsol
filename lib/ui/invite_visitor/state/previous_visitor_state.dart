import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pif_flutter/ui/invite_visitor/model/invite_visitor_model.dart';

part 'previous_visitor_state.freezed.dart';

@freezed
class PreviousVisitorState with _$PreviousVisitorState {
  const factory PreviousVisitorState({
    required List<InviteVisitorModel> lstData,
    required bool isVisibleCancel,
  }) = _PreviousVisitorState;

  factory PreviousVisitorState.initial() => const PreviousVisitorState(
        lstData: <InviteVisitorModel>[],
        isVisibleCancel: false,
      );
}
