import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pif_flutter/ui/visit/invite_edit_visit/model/invite_edit_visit_model.dart';

part 'previous_visitor_state.freezed.dart';

@freezed
class PreviousVisitorState with _$PreviousVisitorState {
  const factory PreviousVisitorState({
    required List<InviteVisitorModel> previousVisitorList,
    required bool isVisibleCancel,
  }) = _PreviousVisitorState;

  factory PreviousVisitorState.initial() => const PreviousVisitorState(
        previousVisitorList: <InviteVisitorModel>[],
        isVisibleCancel: false,
      );
}
