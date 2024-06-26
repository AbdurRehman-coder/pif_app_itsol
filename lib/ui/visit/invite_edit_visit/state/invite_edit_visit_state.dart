import 'package:dixels_sdk/features/commerce/visit/models/visitor_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/ui/visit/invite_edit_visit/model/invite_edit_visit_model.dart';

part 'invite_edit_visit_state.freezed.dart';

@freezed
class InviteEditVisitState with _$InviteEditVisitState {
  const factory InviteEditVisitState({
    required DateTime? startDate,
    required DateTime startTime,
    required DateTime? endDate,
    required DateTime endTime,
    required List<InviteVisitorModel> lstData,
    required AsyncValue<List<VisitorModel>> visitorModelList,
    required bool isOpenStartDatePicker,
    required bool isOpenEndDatePicker,
    required bool isOpenStartTimePicker,
    required bool isOpenEndTimePicker,
    required bool isFieldDisable,
  }) = _InviteEditVisitState;

  factory InviteEditVisitState.initial() => InviteEditVisitState(
        lstData: <InviteVisitorModel>[],
        isOpenStartDatePicker: false,
        isOpenEndDatePicker: false,
        isOpenStartTimePicker: false,
        isOpenEndTimePicker: false,
        startDate: null,
        endDate: null,
        visitorModelList: const AsyncLoading(),
        endTime: DateTime.now().add(const Duration(hours: 1)),
        startTime: DateTime.now(),
        isFieldDisable: true,
      );
}
