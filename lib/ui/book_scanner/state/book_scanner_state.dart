import 'package:freezed_annotation/freezed_annotation.dart';

part 'book_scanner_state.freezed.dart';

@freezed
class BookScannerState with _$BookScannerState {
  const factory BookScannerState({
    required bool isLoading,
  }) = _BookScannerState;

  factory BookScannerState.initial() => const BookScannerState(
        isLoading: true,
      );
}
