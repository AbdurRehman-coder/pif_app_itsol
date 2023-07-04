import 'package:collection/collection.dart';
import 'package:dixels_sdk/dixels_sdk.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pif_flutter/common/extensions/date_time_extension.dart';
import 'package:pif_flutter/common/shared/message/toast_message.dart';
import 'package:pif_flutter/generated/l10n.dart';
import 'package:pif_flutter/ui/space_booking/index.dart';

final filterByProvider = StateNotifierProvider.autoDispose<FilterByNotifier, FilterByState>((ref) {
  return FilterByNotifier(ref: ref);
});

class FilterByNotifier extends StateNotifier<FilterByState> {
  FilterByNotifier({required this.ref}) : super(FilterByState.initial()) {
    // setDefaultTime();
    _initData();
  }

  final Ref ref;

  late TextEditingController startTimeController;
  late TextEditingController endTimeController;

  List<DateTime> selectedDateLst = <DateTime>[];
  List<DateTime> confirmDateLst = <DateTime>[];

  Future<void> _initData() async {
    startTimeController = TextEditingController();
    endTimeController = TextEditingController();
    await _getFloors();
    final currentDateTime = DateTime.now();
    final currentDate = DateTime(currentDateTime.year, currentDateTime.month, currentDateTime.day, 12);
    selectedDateLst.add(currentDate);
    if (currentDate.weekday != DateTime.friday && currentDate.weekday != DateTime.saturday) {
      confirmDateLst.addAll(selectedDateLst);
      state = state.copyWith(selectedDateList: confirmDateLst);
      formatSelectedDateToString();
    }

    final data = ref.read(spaceBookingProvider);
    if (data.filterData != null) {
      state = state.copyWith(selectedDateList: data.filterData!.selectedDates);
      state = state.copyWith(selectedDateList: data.filterData!.selectedDates);
      state = state.copyWith(capacity: int.parse(data.filterData!.capacity));

      if (data.filterData!.startTime != null) {
        final startTimeString = DateFormat('hh:mm a').format(data.filterData!.startTime!);
        startTimeController.text = startTimeString;
        state = state.copyWith(startTime: data.filterData!.startTime);
      }

      if (data.filterData!.endTime != null) {
        final endTimeString = DateFormat('hh:mm a').format(data.filterData!.endTime!);
        endTimeController.text = endTimeString;
        state = state.copyWith(endTime: data.filterData!.endTime);
      }

      final lstFloors = state.lstFloors.toList();
      for (final item in data.filterData!.selectedFloors) {
        final data = lstFloors.firstWhere((element) => element.id == item!.id);
        data.isSelected = true;
      }

      state = state.copyWith(lstFloors: lstFloors);
      formatSelectedDateToString();
    }
  }

  //Get Foors Data
  Future<void> _getFloors() async {
    final result = await DixelsSDK.instance.floorService.getPageData(fromJson: FloorModel.fromJson);
    if (result != null) {
      state = state.copyWith(lstFloors: result.items!);
    }
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
    if (selectedDateLst.contains(date)) {
      selectedDateLst.remove(date);
    } else {
      if (selectedDateLst.length < 10) {
        selectedDateLst.add(date);
      }
    }
  }

  void confirm() {
    confirmDateLst.clear();
    confirmDateLst.addAll(selectedDateLst);
    state = state.copyWith(selectedDateList: confirmDateLst);
    formatSelectedDateToString();
  }

  void cancel() {
    state = state.copyWith(selectedDateList: confirmDateLst);
    selectedDateLst.clear();
    selectedDateLst.addAll(confirmDateLst);
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
    if (state.isOpenStartTimePicker) {
      closeStartTimePickerDialog();
    }
    if (state.isOpenEndTimePicker) {
      closeEndTimePickerDialog();
    }

    Future.delayed(Duration.zero, () {
      state = state.copyWith(isOpenPopup: true);
    });
  }

  //Close DatePicker Dialog
  void closeDialog() {
    state = state.copyWith(isOpenPopup: false);
  }

  //Open StartTime Picker Dialog
  void openStartTimePickerDialog() {
    if (state.isOpenEndTimePicker) {
      closeEndTimePickerDialog();
    }

    if (state.isOpenPopup) {
      closeDialog();
    }
    state = state.copyWith(isOpenStartTimePicker: true);
  }

  //Close StartTime Picker Dialog
  void closeStartTimePickerDialog() {
    state = state.copyWith(isOpenStartTimePicker: false);
  }

  //Open EndTime Picker Dialog
  void openEndTimePickerDialog() {
    if (state.isOpenStartTimePicker) {
      closeStartTimePickerDialog();
    }
    if (state.isOpenPopup) {
      closeDialog();
    }
    state = state.copyWith(isOpenEndTimePicker: true);
  }

  //Close StartTime Picker Dialog
  void closeEndTimePickerDialog() {
    state = state.copyWith(isOpenEndTimePicker: false);
  }

  //Reset Filter Data
  void resetFilter() {
    startTimeController.clear();
    endTimeController.clear();
    state = state.copyWith(selectedDateList: <DateTime>[]);
    state = state.copyWith(selectedDateString: '');
    state = state.copyWith(capacity: 1);
    state = state.copyWith(startTime: null);
    state = state.copyWith(endTime: null);

    final lstFloor = state.lstFloors.toList();
    for (final item in lstFloor) {
      item.isSelected = false;
    }
    state = state.copyWith(lstFloors: lstFloor);

    // updateDateString(DateTime.now());
    // final data = ref.read(spaceBookingProvider.notifier);
    // data.clearFilterData();
  }

  //Set Default DateTime
  void setDefaultTime() {
    final dateTime = DateTime.now();
    final minute = dateTime.minute;
    final minuteModulo = minute % 15;
    var roundedTime = dateTime.subtract(Duration(minutes: minuteModulo));

    roundedTime =
        DateTime(roundedTime.year, roundedTime.month, roundedTime.day, roundedTime.hour, roundedTime.minute);
    state = state.copyWith(startTime: roundedTime);
    state = state.copyWith(endTime: roundedTime.add(const Duration(minutes: 15)));
    updateStartTime(startTime: state.startTime);
  }

  //Update Start Time
  void updateStartTime({required DateTime? startTime}) {
    startTime = DateTime(startTime!.year, startTime.month, startTime.day, startTime.hour, startTime.minute);
    state = state.copyWith(startTime: startTime);

    final startTimeString = DateFormat('hh:mm a').format(startTime);
    startTimeController.text = startTimeString;
  }

  //Update End Time
  void updateEndTime({required DateTime? endTime, required BuildContext context}) {
    endTime = DateTime(endTime!.year, endTime.month, endTime.day, endTime.hour, endTime.minute);
    if (state.startTime != null && state.startTime!.isAfter(endTime)) {
      alertMessage(errorMessage: S.current.timeValidation, context: context);
      return;
    }
    state = state.copyWith(endTime: endTime);

    final endTimeString = DateFormat('hh:mm a').format(endTime);
    endTimeController.text = endTimeString;
  }
}
