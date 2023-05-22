import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pif_flutter/generated/l10n.dart';
import 'package:pif_flutter/helpers/common_utils.dart';
import 'package:pif_flutter/ui/space_booking/provider/room_booking_filter_state.dart';

final roomBookingProvider = StateNotifierProvider.autoDispose<RoomBookingNotifier, RoomBookingState>((ref) {
  return RoomBookingNotifier(ref: ref);
});

class RoomBookingNotifier extends StateNotifier<RoomBookingState> {
  RoomBookingNotifier({required this.ref}) : super(RoomBookingState.initial()) {
    _initData();
  }

  final Ref ref;

  late TextEditingController dateController;
  late TextEditingController startTimeController;
  late TextEditingController endTimeController;

  // Init Data
  void _initData() {
    dateController = TextEditingController();
    startTimeController = TextEditingController();
    endTimeController = TextEditingController();
  }

  //Open DatePicker Dialog
  void openDatePickerDialog() {
    if (state.isOpenStartTimePicker || state.isOpenEndTimePicker) {
      return;
    }
    state = state.copyWith(isOpenDatePicker: true);
  }

  //Update Start Time
  void updateStartTime({required DateTime? startTime}) {
    state = state.copyWith(startTime: startTime);

    final startTimeString = DateFormat('hh:mm a').format(startTime!);
    startTimeController.text = startTimeString;
  }

  //Close StartTime Picker Dialog
  void closeEndTimePickerDialog() {
    state = state.copyWith(isOpenEndTimePicker: false);
  }

  //Open StartTime Picker Dialog
  void openStartTimePickerDialog() {
    state = state.copyWith(isOpenStartTimePicker: true);
  }

  //Close DatePicker Dialog
  void closeDatePickerDialog() {
    state = state.copyWith(isOpenDatePicker: false);
  }

  //Close StartTime Picker Dialog
  void closeStartTimePickerDialog() {
    state = state.copyWith(isOpenStartTimePicker: false);
  }

  //Open EndTime Picker Dialog
  void openEndTimePickerDialog() {
    state = state.copyWith(isOpenEndTimePicker: true);
  }

  //Update End Time
  void updateEndTime({required DateTime? endTime}) {
    if (endTime != null && state.startTime!.isAfter(endTime)) {
      CommonUtils.showToast(message: S.current.timeValidation);
      return;
    }
    state = state.copyWith(endTime: endTime);

    final endTimeString = DateFormat('hh:mm a').format(endTime!);
    endTimeController.text = endTimeString;
  }

  //Update Selected Date Data
  void updateDateString(DateTime date) {
    final dateList = state.selectedDates.toList();
    if (dateList.length == 10) {
      return;
    }
    if (dateList.contains(date)) {
      dateList.remove(date);
    } else {
      dateList.add(date);
    }

    state = state.copyWith(selectedDates: dateList);
    final dateFormat = DateFormat('d');
    if (dateList.isEmpty) {
      state = state.copyWith(selectedDateString: '');
      dateController.text = state.selectedDateString;
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

    dateController.text = lastDateString;
  }
}
