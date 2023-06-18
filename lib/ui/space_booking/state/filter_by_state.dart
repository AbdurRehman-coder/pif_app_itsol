import 'package:dixels_sdk/dixels_sdk.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'filter_by_state.freezed.dart';

@freezed
class FilterByState with _$FilterByState {
  const factory FilterByState({
    required String selectedDateString,
    required bool isOpenPopup,
    required bool isOpenTimePicker,
    required bool isOpenStartTimePicker,
    required bool isOpenEndTimePicker,
    required DateTime selectedSingleDate,
    required List<DateTime> selectedDateList,
    required List<FloorModel> lstFloors,
    required DateTime? startTime,
    required DateTime? endTime,
    required int capacity,
    required RangeValues rangeData,
  }) = _FilterByState;

  factory FilterByState.initial() => FilterByState(
        selectedDateString: '',
        isOpenPopup: false,
        isOpenTimePicker: false,
        selectedSingleDate: DateTime.now(),
        selectedDateList: <DateTime>[],
        lstFloors: <FloorModel>[],
        startTime: null,
        endTime: null,
        capacity: 1,
        isOpenStartTimePicker: false,
        isOpenEndTimePicker: false,
        rangeData: const RangeValues(660, 675),
      );
}
