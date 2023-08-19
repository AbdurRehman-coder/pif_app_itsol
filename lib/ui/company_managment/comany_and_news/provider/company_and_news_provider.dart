import 'package:dixels_sdk/common/models/parameters_model.dart';
import 'package:dixels_sdk/dixels_sdk.dart';
import 'package:dixels_sdk/features/commerce/company_managment/model/company_management_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/ui/company_managment/comany_and_news/state/company_and_news_state.dart';

final companyAndNewsProvider = StateNotifierProvider.autoDispose<CompanyAndNewsNotifier, CompanyAndNewsState>((ref) {
  return CompanyAndNewsNotifier(ref: ref);
});

class CompanyAndNewsNotifier extends StateNotifier<CompanyAndNewsState> {
  CompanyAndNewsNotifier({required this.ref}) : super(CompanyAndNewsState.initial());

  final Ref ref;

  Future<void> getCompanyManagement() async {
    final param = ParametersModel(
      nestedFields: 'residents',
    );
    final result = await DixelsSDK.instance.companyManagementServices.getPageDataWithEither(
      fromJson: CompanyManagementModel.fromJson,
      params: param,
    );
    if (result.isRight()) {
      state = state.copyWith(
        companyManagementList: AsyncData(
          result.getRight()!.items ?? [],
        ),
      );
    }
  }
}
