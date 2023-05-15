import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pif_flutter/ui/booking/model/day_header_model.dart';

part 'booking_state.freezed.dart';

@freezed
class BookingState with _$BookingState {
  const factory BookingState({
    required String bookingTitle,
    required List<DateTime> selectedDates,
    required String selectedDateString,
    required DateTime startTime,
    required DateTime endTime,
    required bool isOpenDatePicker,
    required bool isOpenStartTimePicker,
    required bool isOpenEndTimePicker,
    required List<DayHeaderModel> lstDays,
  }) = _BookingState;

  factory BookingState.initial() => BookingState(
        bookingTitle: '',
        selectedDates: <DateTime>[],
        selectedDateString: '',
        startTime: DateTime.now(),
        endTime: DateTime.now(),
        isOpenDatePicker: false,
        isOpenStartTimePicker: false,
        isOpenEndTimePicker: false,
        lstDays: <DayHeaderModel>[],
      );
}
