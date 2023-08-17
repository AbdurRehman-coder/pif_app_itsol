import 'package:dixels_sdk/features/commerce/company_managment/model/company_management_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'company_and_news_state.freezed.dart';

@freezed
class CompanyAndNewsState with _$CompanyAndNewsState {
  const factory CompanyAndNewsState({
    required AsyncValue<List<String>> companyList,
    required AsyncValue<List<CompanyManagementModel>> companyManagementList,
  }) = _CompanyAndNewsState;

  factory CompanyAndNewsState.initial() => const CompanyAndNewsState(
        companyList: AsyncLoading(),
        companyManagementList: AsyncLoading(),
      );
}
