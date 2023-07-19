import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/ui/company_details/model/company_details_model.dart';
import 'package:pif_flutter/ui/employee_details/index.dart';

final employeeDetailsProvider = StateNotifierProvider.autoDispose<EmployeeDetailsNotifier, EmployeeDetailsState>((ref) {
  return EmployeeDetailsNotifier(ref: ref);
});

class EmployeeDetailsNotifier extends StateNotifier<EmployeeDetailsState> {
  EmployeeDetailsNotifier({required this.ref}) : super(EmployeeDetailsState.initial()) {
    _initData();
  }

  final Ref ref;
  final lstService = <CompanyDetailsModel>[];
  final lstEmployee = <EmployeeDetailsModel>[];

  void _initData() {
    lstService.add(CompanyDetailsModel(id: 0, companyService: 'Photography', selected: false));
    lstService.add(CompanyDetailsModel(id: 1, companyService: 'Technology', selected: false));
    lstService.add(CompanyDetailsModel(id: 2, companyService: 'Technology', selected: false));
    for (var i = 0; i < 5; i++) {
      lstEmployee.add(EmployeeDetailsModel(address: 'Al Multaqa 304', streetName: 'Incubated since 2022'));
    }

    state = state.copyWith(lstService: lstService, lstEmployee: lstEmployee);
  }

  void isPreferenceVisible() {
    state = state.copyWith(
      isPreferenceVisible: !state.isPreferenceVisible,
      isGeneralVisible: false,
    );
  }

  void isGeneralVisible() {
    state = state.copyWith(
      isGeneralVisible: !state.isGeneralVisible,
      isPreferenceVisible: false,
    );
  }
}
