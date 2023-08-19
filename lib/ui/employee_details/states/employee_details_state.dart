import 'package:freezed_annotation/freezed_annotation.dart';

part 'employee_details_state.freezed.dart';

@freezed
class EmployeeDetailsState with _$EmployeeDetailsState {
  const factory EmployeeDetailsState({
    required bool isGeneralVisible,
    required bool isPreferenceVisible,
    required String userProfileImage,
    String? spaceName,
    String? spaceImage,
    String? spaceSinceYear,
  }) = _EmployeeDetailsState;

  factory EmployeeDetailsState.initial() => const EmployeeDetailsState(
        isGeneralVisible: true,
        isPreferenceVisible: false,
        userProfileImage: '',
      );
}
