import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/ui/company_details/index.dart';

final companyDetailsProvider =
    StateNotifierProvider.autoDispose<CompanyDetailsNotifier, CompanyDetailsState>((ref) {
  return CompanyDetailsNotifier(ref: ref);
});

class CompanyDetailsNotifier extends StateNotifier<CompanyDetailsState> {
  CompanyDetailsNotifier({required this.ref}) : super(CompanyDetailsState.initial()) {
    _initData();
  }

  final Ref ref;
  final lstService = <CompanyDetailsModel>[];
  final lstUser = <CompanyDetailsUserModel>[];

  void _initData() {
    lstService.add(CompanyDetailsModel(id: 0, companyService: 'Photography', selected: false));
    lstService.add(CompanyDetailsModel(id: 1, companyService: 'Technology', selected: false));
    lstService.add(CompanyDetailsModel(id: 2, companyService: 'Technology', selected: false));

    for (var i = 0; i < 7; i++) {
      lstUser.add(CompanyDetailsUserModel(designation: 'Product owner', userName: 'Khaled moh'));
    }

    state = state.copyWith(lstService: lstService, lstUser: lstUser);
  }
}
