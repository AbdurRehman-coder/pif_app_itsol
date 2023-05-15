import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/routes/app_router.dart';
import 'package:pif_flutter/routes/routes.dart';
import 'package:pif_flutter/ui/booking/state/booking_confirmation_state.dart';

final bookingConfirmationProvider =
    StateNotifierProvider.autoDispose<BookingConfirmationNotifier, BookingConfirmationState>((ref) {
  return BookingConfirmationNotifier(ref: ref);
});

class BookingConfirmationNotifier extends StateNotifier<BookingConfirmationState> {
  BookingConfirmationNotifier({required this.ref}) : super(BookingConfirmationState.initial()) {
    _initTimer();
  }

  final Ref ref;

  Timer? _timer;

  void _initTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      state = state.copyWith(sliderValue: state.sliderValue + 50);
      if (state.sliderValue == 3000) {
        _timer?.cancel();
        AppRouter.popUntil(Routes.spaceBookingScreen);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }
}
