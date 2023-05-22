import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pif_flutter/ui/booking/model/day_header_model.dart';
import 'package:pif_flutter/ui/booking/model/invite_guest_model.dart';

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
    required List<InviteGuestModel> lstGuests,
    required List<InviteGuestModel> lstAutoCompleteGuests,
    required bool isVisibleAddGuestList,
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
        lstGuests: <InviteGuestModel>[],
        errorMessage: '',
        lstAutoCompleteGuests: <InviteGuestModel>[],
        isVisibleAddGuestList: false,
      );
}
