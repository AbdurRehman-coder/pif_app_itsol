import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pif_flutter/ui/company_details/index.dart';

part 'company_details_state.freezed.dart';

@freezed
class CompanyDetailsState with _$CompanyDetailsState {
  const factory CompanyDetailsState({
    required List<CompanyDetailsModel> lstService,
    required List<CompanyDetailsUserModel> lstUser,
  }) = _CompanyDetailsState;

  factory CompanyDetailsState.initial() => const CompanyDetailsState(
        lstService: <CompanyDetailsModel>[],
        lstUser: <CompanyDetailsUserModel>[],
      );
}
