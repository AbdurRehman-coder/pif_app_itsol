import 'package:freezed_annotation/freezed_annotation.dart';

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
      );
}
