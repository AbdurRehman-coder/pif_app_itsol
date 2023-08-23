import 'package:dixels_sdk/dixels_sdk.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/message/toast_message.dart';
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

  late TextEditingController startDateController;
  late TextEditingController endDateController;
  late TextEditingController startTimeController;
  late TextEditingController endTimeController;

  List<DateTime> selectedDateLst = <DateTime>[];
  List<DateTime> confirmDateLst = <DateTime>[];

  Future<void> _initData() async {
    startDateController = TextEditingController();
    endDateController = TextEditingController();
    startTimeController = TextEditingController();
    endTimeController = TextEditingController();
    await _getFloors();
    final currentDateTime = DateTime.now();
    final currentDate = DateTime(currentDateTime.year, currentDateTime.month, currentDateTime.day, 12);
    selectedDateLst.add(currentDate);
    if (currentDate.weekday != DateTime.friday && currentDate.weekday != DateTime.saturday) {
      confirmDateLst.addAll(selectedDateLst);
      state = state.copyWith(selectedDateList: confirmDateLst);
    }

    final data = ref.read(spaceBookingProvider);
    if (data.filterData != null) {
      state = state.copyWith(capacity: int.parse(data.filterData!.capacity));

      state = state.copyWith(startDate: data.filterData!.startDate);
      startDateController.text = DateFormat('dd MMM yyyy').format(data.filterData!.startDate);

      state = state.copyWith(endDate: data.filterData!.endDate);
      endDateController.text = DateFormat('dd MMM yyyy').format(data.filterData!.endDate);

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

  //Open start DatePicker Dialog
  void openStartDatePicker() {
    if (state.isOpenEndDatePicker) {
      closeEndDatePicker();
    }
    if (state.isOpenStartTimePicker) {
      closeStartTimePickerDialog();
    }
    if (state.isOpenEndTimePicker) {
      closeEndTimePickerDialog();
    }

    Future.delayed(Duration.zero, () {
      state = state.copyWith(isOpenStartDatePicker: true);
    });
  }

  //Close start DatePicker Dialog
  void closeStartDatePicker() {
    state = state.copyWith(isOpenStartDatePicker: false);
  }

  //Open end DatePicker Dialog
  void openEndDatePicker() {
    if (state.isOpenStartDatePicker) {
      closeStartDatePicker();
    }
    if (state.isOpenStartTimePicker) {
      closeStartTimePickerDialog();
    }
    if (state.isOpenEndTimePicker) {
      closeEndTimePickerDialog();
    }

    Future.delayed(Duration.zero, () {
      state = state.copyWith(isOpenEndDatePicker: true);
    });
  }

  //Close DatePicker Dialog
  void closeEndDatePicker() {
    state = state.copyWith(isOpenEndDatePicker: false);
  }

  //Open StartTime Picker Dialog
  void openStartTimePickerDialog() {
    if (state.isOpenStartDatePicker) {
      closeStartDatePicker();
    }
    if (state.isOpenEndDatePicker) {
      closeEndDatePicker();
    }
    if (state.isOpenEndTimePicker) {
      closeEndTimePickerDialog();
    }

    state = state.copyWith(isOpenStartTimePicker: true);
  }

  //Close StartTime Picker Dialog
  void closeStartTimePickerDialog() {
    state = state.copyWith(isOpenStartTimePicker: false);
  }

  //Open EndTime Picker Dialog
  void openEndTimePickerDialog() {
    if (state.isOpenStartDatePicker) {
      closeStartDatePicker();
    }
    if (state.isOpenEndDatePicker) {
      closeEndDatePicker();
    }
    if (state.isOpenStartTimePicker) {
      closeStartTimePickerDialog();
    }

    state = state.copyWith(isOpenEndTimePicker: true);
  }

  //Close StartTime Picker Dialog
  void closeEndTimePickerDialog() {
    state = state.copyWith(isOpenEndTimePicker: false);
  }

  //Update Start Date
  void updateStartDate(DateTime date) {
    state = state.copyWith(startDate: date);
    startDateController.text = DateFormat('dd MMM yyyy').format(date);

    if (endDateController.text.isEmpty) {
      state = state.copyWith(endDate: date);
      endDateController.text = DateFormat('dd MMM yyyy').format(date);
    }

    closeStartDatePicker();
  }

  //Update End Date
  void updateEndDate(DateTime date) {
    state = state.copyWith(endDate: date);
    endDateController.text = DateFormat('dd MMM yyyy').format(date);

    closeEndDatePicker();
  }

  //Reset Filter Data
  void resetFilter() {
    startTimeController.clear();
    endTimeController.clear();
    startDateController.clear();
    endDateController.clear();
    final lstFloor = state.lstFloors.toList();
    for (final item in lstFloor) {
      item.isSelected = false;
    }

    state = state.copyWith(
      selectedDateList: <DateTime>[],
      selectedDateString: '',
      capacity: 0,
      startDate: DateTime.now(),
      endDate: DateTime.now(),
      startTime: null,
      endTime: null,
      lstFloors: lstFloor,
    );

    // updateDateString(DateTime.now());
    // final data = ref.read(spaceBookingProvider.notifier);
    // data.clearFilterData();
  }

  //Update Start Time
  void updateStartTime({required DateTime? startTime}) {
    startTime = DateTime(startTime!.year, startTime.month, startTime.day, startTime.hour, startTime.minute);
    state = state.copyWith(startTime: startTime);

    final startTimeString = DateFormat('hh:mm a').format(startTime);
    startTimeController.text = startTimeString;

    state = state.copyWith(endTime: startTime.add(const Duration(minutes: 15)));

    final endTimeString = DateFormat('hh:mm a').format(startTime.add(const Duration(minutes: 15)));
    endTimeController.text = endTimeString;
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

  @override
  void dispose() {
    startDateController.dispose();
    endDateController.dispose();
    startTimeController.dispose();
    endTimeController.dispose();
    super.dispose();
  }
}
