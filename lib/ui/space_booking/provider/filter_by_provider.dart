import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pif_flutter/generated/l10n.dart';
import 'package:pif_flutter/helpers/common_utils.dart';
import 'package:pif_flutter/ui/space_booking/model/floor_model.dart';
import 'package:pif_flutter/ui/space_booking/state/filter_by_state.dart';

final filterByProvider = StateNotifierProvider.autoDispose<FilterByNotifier, FilterByState>((ref) {
  return FilterByNotifier(ref: ref);
});

class FilterByNotifier extends StateNotifier<FilterByState> {
  FilterByNotifier({required this.ref}) : super(FilterByState.initial()) {
    getFloors();
    setDefaultTime();
  }

  final Ref ref;

  void getFloors() {
    final lstFloors = <FloorModel>[];
    lstFloors.add(
      FloorModel(
        floorId: '1',
        floorName: 'Base camp',
        isSelected: false,
      ),
    );
    lstFloors.add(
      FloorModel(
        floorId: '2',
        floorName: 'Floor 1',
        isSelected: true,
      ),
    );
    lstFloors.add(
      FloorModel(
        floorId: '3',
        floorName: 'Floor2',
        isSelected: false,
      ),
    );
    lstFloors.add(
      FloorModel(
        floorId: '4',
        floorName: '3’rd Floor',
        isSelected: false,
      ),
    );
    lstFloors.add(
      FloorModel(
        floorId: '5',
        floorName: 'Floor4',
        isSelected: false,
      ),
    );

    state = state.copyWith(lstFloors: lstFloors);
  }

  void updateFloorList({required int index}) {
    final data = state.lstFloors[index];
    data.isSelected = !(data.isSelected ?? false);

    state = state.copyWith(lstFloors: state.lstFloors);
  }

  void addCapacity() {
    if (state.capacity >= 20) {
      return;
    }
    final capacityCount = state.capacity + 1;
    state = state.copyWith(capacity: capacityCount);
  }

  void removeCapacity() {
    if (state.capacity <= 1) {
      return;
    }
    final capacityCount = state.capacity - 1;
    state = state.copyWith(capacity: capacityCount);
  }

  void updateDateString(DateTime date) {
    final dateList = state.selectedDateList.toList();
    if (dateList.length == 10) {
      return;
    }
    if (dateList.contains(date)) {
      dateList.remove(date);
    } else {
      dateList.add(date);
    }

    state = state.copyWith(selectedDateList: dateList);
    final dateFormat = DateFormat('d');
    if (dateList.isEmpty) {
      state = state.copyWith(selectedDateString: '');
      return;
    }

    final groupedDates = groupBy<DateTime, String>(
      dateList,
      (date) => DateFormat('MMM').format(date),
    );

    var lastDateString = '';
    groupedDates.forEach((key, value) {
      final dateStrings = value.map(dateFormat.format).join(', ');
      lastDateString = '$lastDateString $dateStrings $key';
    });
    state = state.copyWith(selectedDateString: lastDateString);
  }

  void openDialog() {
    if (state.isOpenTimePicker) {
      return;
    }
    state = state.copyWith(isOpenPopup: true);
  }

  void closeDialog() {
    state = state.copyWith(isOpenPopup: false);
  }

  void openTimePickerDialog() {
    if (state.selectedDateString.isEmpty) {
      CommonUtils.showToast(message: S.current.dateValidation);
      return;
    }
    state = state.copyWith(isOpenTimePicker: true);
  }

  void closeTimePickerDialog() {
    if (state.startTime.isAfter(state.endTime)) {
      CommonUtils.showToast(message: S.current.timeValidation);
      return;
    }
    state = state.copyWith(isOpenTimePicker: false);
  }

  void updateTime({required DateTime? startTime, required DateTime? endTime}) {
    state = state.copyWith(startTime: startTime!);
    state = state.copyWith(endTime: endTime!);

    final startTimeString = DateFormat('hh:mm a').format(startTime);
    final endTimeString = DateFormat('hh:mm a').format(endTime);

    state = state.copyWith(timeString: '$startTimeString - $endTimeString');
  }

  void updateRangeValue({required RangeValues rangeData}) {
    final startDateTime = DateTime(2023, 1, 1, 0, rangeData.start.toInt());
    final endDateTime = DateTime(2023, 1, 1, 0, rangeData.end.toInt());

    final startTimeString = DateFormat('hh:mm a').format(startDateTime);
    final endTimeString = DateFormat('hh:mm a').format(endDateTime);

    state = state.copyWith(rangeData: rangeData);
    state = state.copyWith(timeString: '$startTimeString - $endTimeString');
  }

  void resetFilter() {}

  void setDefaultTime() {
    final dateTime = DateTime.now();
    final minute = dateTime.minute;
    final minuteModulo = minute % 15;
    final roundedTime = dateTime.subtract(Duration(minutes: minuteModulo));

    state = state.copyWith(startTime: roundedTime);
    state = state.copyWith(endTime: roundedTime.add(const Duration(minutes: 15)));
    final startTimeString = DateFormat('h:mm a').format(roundedTime);
    final endTimeString = DateFormat('h:mm a').format(roundedTime.add(const Duration(minutes: 15)));
    state = state.copyWith(timeString: '$startTimeString - $endTimeString');
  }
}
