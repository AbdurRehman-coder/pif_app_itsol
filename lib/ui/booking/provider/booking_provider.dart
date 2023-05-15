import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pif_flutter/helpers/common_utils.dart';
import 'package:pif_flutter/ui/booking/state/booking_state.dart';
import 'package:pif_flutter/utils/colors.dart';
import 'package:pif_flutter/utils/styles.dart';
import 'package:pif_flutter/widgets/day_calendar_widget/time_planner_date_time.dart';
import 'package:pif_flutter/widgets/day_calendar_widget/time_planner_task.dart';

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

    state = state.copyWith(lstDays: CommonUtils.getNextSevenDays());
    getTasks();
  }

  final Ref ref;
  late TextEditingController titleController;
  late TextEditingController dateController;
  late TextEditingController startTimeController;
  late TextEditingController endTimeController;
  late List<TimePlannerTask> lstTasks = [];

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

  void updateDays({required int index}) {
    for (final element in state.lstDays) {
      element.isSelected = false;
    }
    state.lstDays[index].isSelected = true;
    state = state.copyWith(lstDays: state.lstDays);
    getTasks();
  }

  void bookNowAsync() {}

  void getTasks() {
    lstTasks.clear();
    final selectedDay = state.lstDays.firstWhere((element) => element.isSelected == true);
    if (selectedDay.dayDate == DateTime.now().day.toString()) {
      lstTasks.add(
        TimePlannerTask(
          color: primaryColor,
          leftSpace: 30,
          dateTime: TimePlannerDateTime(
            day: DateTime(2023, 5, 11, 22, 0, 0).day,
            hour: DateTime(2023, 5, 11, 22, 0, 0).hour,
            minutes: DateTime(2023, 5, 11, 22, 0, 0).minute,
          ),
          minutesDuration: 60,
          onTap: () {},
          child: Text(
            'Booking for [Fahad O.]',
            style: Style.commonTextStyle(
              color: whiteColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );

      lstTasks.add(
        TimePlannerTask(
          color: primaryColor,
          leftSpace: 30,
          dateTime: TimePlannerDateTime(
            day: DateTime(2023, 5, 11, 2, 0, 0).day,
            hour: DateTime(2023, 5, 11, 2, 0, 0).hour,
            minutes: DateTime(2023, 5, 11, 2, 0, 0).minute,
          ),
          minutesDuration: 30,
          onTap: () {},
          child: Text(
            'Booking for [Fahad O.]',
            style: Style.commonTextStyle(
              color: whiteColor,
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
    } else if (selectedDay.dayDate == DateTime.now().add(const Duration(days: 1)).day.toString()) {
      lstTasks.add(
        TimePlannerTask(
          color: primaryColor,
          leftSpace: 30,
          dateTime: TimePlannerDateTime(
            day: DateTime(2023, 5, 11, 4, 0, 0).day,
            hour: DateTime(2023, 5, 11, 4, 0, 0).hour,
            minutes: DateTime(2023, 5, 11, 4, 0, 0).minute,
          ),
          minutesDuration: 15,
          onTap: () {},
          child: Text(
            'Booking for [Fahad O.]',
            style: Style.commonTextStyle(
              color: whiteColor,
              fontSize: 8.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );

      lstTasks.add(
        TimePlannerTask(
          isBlocked: true,
          color: primaryColor,
          leftSpace: 30,
          dateTime: TimePlannerDateTime(
            day: DateTime(2023, 5, 11, 5, 0, 0).day,
            hour: DateTime(2023, 5, 11, 5, 0, 0).hour,
            minutes: DateTime(2023, 5, 11, 5, 0, 0).minute,
          ),
          minutesDuration: 75,
          onTap: () {},
          child: Text(
            'Booking for [Fahad O.]',
            style: Style.commonTextStyle(
              color: whiteColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    dateController.dispose();
    startTimeController.dispose();
    endTimeController.dispose();
    super.dispose();
  }
}
