import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pif_flutter/ui/booking/state/booking_state.dart';

final bookingProvider = StateNotifierProvider.autoDispose<BookingNotifier, BookingState>((ref) {
  return BookingNotifier(ref: ref);
});

class BookingNotifier extends StateNotifier<BookingState> {
  BookingNotifier({required this.ref}) : super(BookingState.initial()) {
    _initData();
  }

  void _initData() {
    titleController = TextEditingController();
    dateController = TextEditingController();
    startTimeController = TextEditingController();
    endTimeController = TextEditingController();
  }

  final Ref ref;
  late TextEditingController titleController;
  late TextEditingController dateController;
  late TextEditingController startTimeController;
  late TextEditingController endTimeController;

  void updateStartTime({required DateTime? startTime}) {
    state = state.copyWith(startTime: startTime!);

    final startTimeString = DateFormat('hh:mm a').format(startTime);
    startTimeController.text = startTimeString;
  }

  void updateEndTime({required DateTime? endTime}) {
    state = state.copyWith(endTime: endTime!);

    final endTimeString = DateFormat('hh:mm a').format(endTime);
    endTimeController.text = endTimeString;
  }

  void openDatePickerDialog() {
    state = state.copyWith(isOpenDatePicker: true);
  }

  void closeDatePickerDialog() {
    state = state.copyWith(isOpenDatePicker: false);
  }

  void openStartTimePickerDialog() {
    state = state.copyWith(isOpenStartTimePicker: true);
  }

  void closeStartTimePickerDialog() {
    state = state.copyWith(isOpenStartTimePicker: false);
  }

  void openEndTimePickerDialog() {
    state = state.copyWith(isOpenEndTimePicker: true);
  }

  void closeEndTimePickerDialog() {
    state = state.copyWith(isOpenEndTimePicker: false);
  }

  void updateDateString(DateTime date) {
    final dateList = state.selectedDates.toList();
    if (dateList.contains(date)) {
      dateList.remove(date);
    } else {
      dateList.add(date);
    }

    state = state.copyWith(selectedDates: dateList);
    final dateFormat = DateFormat('d');
    final dateStrings = dateList.map(dateFormat.format).join(',');
    if (dateList.isEmpty) {
      state = state.copyWith(selectedDateString: '');
      return;
    }
    final lastDateString = "$dateStrings ${DateFormat('MMM').format(dateList.last)}";
    state = state.copyWith(selectedDateString: lastDateString);

    dateController.text = lastDateString;
  }

  void bookNowAsync() {}

  @override
  void dispose() {
    titleController.dispose();
    dateController.dispose();
    startTimeController.dispose();
    endTimeController.dispose();
    super.dispose();
  }
}
