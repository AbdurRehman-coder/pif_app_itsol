import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pif_flutter/ui/space_booking/model/floor_model.dart';

part 'filter_by_state.freezed.dart';

@freezed
class FilterByState with _$FilterByState {
  const factory FilterByState({
    required String selectedDateString,
    required bool isOpenPopup,
    required bool isOpenTimePicker,
    required DateTime selectedSingleDate,
    required List<DateTime> selectedDateList,
    required List<FloorModel> lstFloors,
    required DateTime startTime,
    required DateTime endTime,
    required String timeString,
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
        startTime: DateTime.now(),
        endTime: DateTime.now(),
        capacity: 1,
        timeString: '',
        rangeData: const RangeValues(660, 675),
      );
}
