import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_state.freezed.dart';

@freezed
class LogInState with _$LogInState {
  const factory LogInState({
    required int? otpLength,
    required int? expiryTime,
  }) = _LogInState;

  factory LogInState.initial() => const LogInState(
        otpLength: null,
        expiryTime: null,
      );
}
