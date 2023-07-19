import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pif_flutter/ui/company_details/model/company_details_model.dart';
import 'package:pif_flutter/ui/employee_details/model/employee_details_model.dart';

part 'employee_details_state.freezed.dart';

@freezed
class EmployeeDetailsState with _$EmployeeDetailsState {
  const factory EmployeeDetailsState({
    required List<CompanyDetailsModel> lstService,
    required List<EmployeeDetailsModel> lstEmployee,
    required bool isGeneralVisible,
    required bool isPreferenceVisible,
  }) = _EmployeeDetailsState;

  factory EmployeeDetailsState.initial() => const EmployeeDetailsState(
        lstService: <CompanyDetailsModel>[],
        lstEmployee: <EmployeeDetailsModel>[],
        isGeneralVisible: true,
        isPreferenceVisible: false,
      );
}
