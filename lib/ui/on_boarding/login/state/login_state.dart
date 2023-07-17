import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';

part 'login_state.freezed.dart';

@freezed
class LogInState with _$LogInState {
  const factory LogInState({
    required XFile? imageFile,
  }) = _LogInState;

  factory LogInState.initial() => const LogInState(
        imageFile: null,
      );
}
