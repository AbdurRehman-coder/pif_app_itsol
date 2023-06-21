import 'package:dixels_sdk/dixels_sdk.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pif_flutter/ui/booking/model/day_header_model.dart';
import 'package:pif_flutter/widgets/day_calendar_widget/time_planner_task.dart';

part 'booking_state.freezed.dart';

@freezed
class BookingState with _$BookingState {
  const factory BookingState({
    required String bookingTitle,
    required List<DateTime> selectedDates,
    required String selectedDateString,
    required DateTime? startTime,
    required DateTime? endTime,
    required bool isOpenDatePicker,
    required bool isOpenStartTimePicker,
    required bool isOpenEndTimePicker,
    required List<DayHeaderModel> lstDays,
    required String errorMessage,
    required List<UserModel> lstGuests,
    required List<UserModel> lstAutoCompleteGuests,
    required bool isVisibleAddGuestList,
    required List<TimePlannerTask> lstTasks,
  }) = _BookingState;

  factory BookingState.initial() => const BookingState(
        bookingTitle: '',
        selectedDates: <DateTime>[],
        selectedDateString: '',
        startTime: null,
        endTime: null,
        isOpenDatePicker: false,
        isOpenStartTimePicker: false,
        isOpenEndTimePicker: false,
        lstDays: <DayHeaderModel>[],
        lstGuests: <UserModel>[],
        errorMessage: '',
        lstAutoCompleteGuests: <UserModel>[],
        isVisibleAddGuestList: false,
        lstTasks: <TimePlannerTask>[],
      );
}
