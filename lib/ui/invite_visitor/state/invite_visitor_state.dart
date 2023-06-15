import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pif_flutter/ui/invite_visitor/model/invite_visitor_model.dart';

part 'invite_visitor_state.freezed.dart';

@freezed
class InviteVisitorState with _$InviteVisitorState {
  const factory InviteVisitorState({
    required DateTime startDate,
    required DateTime startTime,
    required DateTime endDate,
    required DateTime endTime,
    required List<InviteVisitorModel> lstData,
    required bool isOpenStartDatePicker,
    required bool isOpenEndDatePicker,
    required bool isOpenStartTimePicker,
    required bool isOpenEndTimePicker,
    required bool isFieldDisable,
  }) = _InviteVisitorState;

  factory InviteVisitorState.initial() => InviteVisitorState(
        lstData: <InviteVisitorModel>[],
        isOpenStartDatePicker: false,
        isOpenEndDatePicker: false,
        isOpenStartTimePicker: false,
        isOpenEndTimePicker: false,
        startDate: DateTime.now(),
        endDate: DateTime.now(),
        endTime: DateTime.now().add(const Duration(hours: 1)),
        startTime: DateTime.now(),
        isFieldDisable: true,
      );
}
