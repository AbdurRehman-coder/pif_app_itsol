import 'package:freezed_annotation/freezed_annotation.dart';

part 'room_booking_filter_state.freezed.dart';

@freezed
class RoomBookingState with _$RoomBookingState {
  const factory RoomBookingState({
    required bool isOpenDatePicker,
    required bool isOpenStartTimePicker,
    required bool isOpenEndTimePicker,
    required String selectedDateString,
    required DateTime? startTime,
    required DateTime? endTime,
    required List<DateTime> selectedDates,
  }) = _RoomBookingState;

  factory RoomBookingState.initial() => const RoomBookingState(
        selectedDateString: '',
        startTime: null,
        endTime: null,
        isOpenDatePicker: false,
        isOpenStartTimePicker: false,
        isOpenEndTimePicker: false,
        selectedDates: <DateTime>[],
      );
}
