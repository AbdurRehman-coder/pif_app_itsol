import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pif_flutter/extensions/date_time_extension.dart';
import 'package:pif_flutter/generated/l10n.dart';
import 'package:pif_flutter/helpers/common_utils.dart';
import 'package:pif_flutter/ui/space_booking/model/floor_model.dart';
import 'package:pif_flutter/ui/space_booking/provider/space_booking_provider.dart';
import 'package:pif_flutter/ui/space_booking/state/filter_by_state.dart';

final filterByProvider = StateNotifierProvider.autoDispose<FilterByNotifier, FilterByState>((ref) {
  return FilterByNotifier(ref: ref);
});

class FilterByNotifier extends StateNotifier<FilterByState> {
  FilterByNotifier({required this.ref}) : super(FilterByState.initial()) {
    setDefaultTime();
    _initData();
    getFloors();
  }

  void _initData() {
    final data = ref.read(spaceBookingProvider);
    if (data.filterData != null) {
      state = state.copyWith(selectedDateList: data.filterData!.selectedDates);
      state = state.copyWith(startTime: data.filterData!.startTime);
      state = state.copyWith(endTime: data.filterData!.endTime);
      state = state.copyWith(capacity: int.parse(data.filterData!.capacity));

      updateTime(startTime: state.startTime, endTime: state.endTime);
      formatSelectedDateToString();
    }
  }

  // FilterModel? filterData;
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

  //Add Capacity
  void addCapacity() {
    if (state.capacity >= 20) {
      return;
    }
    final capacityCount = state.capacity + 1;
    state = state.copyWith(capacity: capacityCount);
  }

  //Remove Capacity
  void removeCapacity() {
    if (state.capacity <= 1) {
      return;
    }
    final capacityCount = state.capacity - 1;
    state = state.copyWith(capacity: capacityCount);
  }

  //Insert or Remove Date into List
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
    formatSelectedDateToString();
  }

  //Format Selected Date String
  void formatSelectedDateToString() {
    final dateList = state.selectedDateList.toList();
    final dateFormat = DateFormat('d');
    if (dateList.isEmpty) {
      state = state.copyWith(selectedDateString: '');
      return;
    }

    final groupedDates = groupBy<DateTime, String>(
      dateList,
      (date) => date.toFormattedString('MMM'),
    );

    var lastDateString = '';
    groupedDates.forEach((key, value) {
      final dateStrings = value.map(dateFormat.format).join(', ');
      lastDateString = '$lastDateString $dateStrings $key';
    });
    state = state.copyWith(selectedDateString: lastDateString);
  }

  //Open DatePicker Dialog
  void openDialog() {
    if (state.isOpenTimePicker) {
      return;
    }
    state = state.copyWith(isOpenPopup: true);
  }

  //Close DatePicker Dialog
  void closeDialog() {
    state = state.copyWith(isOpenPopup: false);
  }

  //Open TimePicker Dialog
  void openTimePickerDialog() {
    if (state.selectedDateString.isEmpty) {
      CommonUtils.showToast(message: S.current.dateValidation);
      return;
    }
    state = state.copyWith(isOpenTimePicker: true);
  }

  //Close TimePicker Dialog
  void closeTimePickerDialog() {
    if (state.startTime.isAfter(state.endTime)) {
      CommonUtils.showToast(message: S.current.timeValidation);
      return;
    }
    state = state.copyWith(isOpenTimePicker: false);
  }

  //Update Time
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

  //Reset Filter Data
  void resetFilter() {
    state = state.copyWith(selectedDateList: <DateTime>[]);
    state = state.copyWith(selectedDateString: '');
    state = state.copyWith(capacity: 1);
  }

  //Set Default DateTime
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
