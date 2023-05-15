import 'package:freezed_annotation/freezed_annotation.dart';

part 'booking_confirmation_state.freezed.dart';

@freezed
class BookingConfirmationState with _$BookingConfirmationState {
  const factory BookingConfirmationState({
    required int sliderValue,
  }) = _BookingConfirmationState;

  factory BookingConfirmationState.initial() => const BookingConfirmationState(
        sliderValue: 0,
      );
}
