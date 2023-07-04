import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_visitor_state.freezed.dart';

@freezed
class AddVisitorState with _$AddVisitorState {
  const factory AddVisitorState({
    required bool isFocusFirstName,
    required bool isFocusLastName,
    required bool isFocusEmail,
  }) = _AddVisitorState;

  factory AddVisitorState.initial() =>
      const AddVisitorState(isFocusFirstName: true, isFocusLastName: false, isFocusEmail: false);
}
