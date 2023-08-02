import 'package:dixels_sdk/dixels_sdk.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'filter_by_state.freezed.dart';

@freezed
class FilterByState with _$FilterByState {
  const factory FilterByState({
    required String selectedDateString,
    required bool isOpenStartDatePicker,
    required bool isOpenStartTimePicker,
    required bool isOpenEndDatePicker,
    required bool isOpenEndTimePicker,
    required DateTime selectedSingleDate,
    required List<DateTime> selectedDateList,
    required List<FloorModel> lstFloors,
    required DateTime startDate,
    required DateTime endDate,
    required DateTime? startTime,
    required DateTime? endTime,
    required int capacity,
    required RangeValues rangeData,
  }) = _FilterByState;

  factory FilterByState.initial() => FilterByState(
        isOpenEndDatePicker: false,
        isOpenEndTimePicker: false,
        isOpenStartDatePicker: false,
        isOpenStartTimePicker: false,
        startDate: DateTime.now(),
        endDate: DateTime.now(),
        selectedDateString: '',
        selectedSingleDate: DateTime.now(),
        selectedDateList: <DateTime>[],
        lstFloors: <FloorModel>[],
        startTime: null,
        endTime: null,
        capacity: 0,
        rangeData: const RangeValues(660, 675),
      );
}
