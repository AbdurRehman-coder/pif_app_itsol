import 'package:dixels_sdk/common/models/parameters_model.dart';
import 'package:dixels_sdk/dixels_sdk.dart';
import 'package:dixels_sdk/features/commerce/company_managment/model/company_management_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/ui/company_managment/comany_and_news/state/company_and_news_state.dart';

final companyAndNewsProvider = StateNotifierProvider.autoDispose<
    CompanyAndNewsNotifier, CompanyAndNewsState>((ref) {
  return CompanyAndNewsNotifier(ref: ref);
});

class CompanyAndNewsNotifier extends StateNotifier<CompanyAndNewsState> {
  CompanyAndNewsNotifier({required this.ref})
      : super(CompanyAndNewsState.initial()) {
    _initData();
  }

  final Ref ref;

  void _initData() {
    getCompanyManagement();
    final companyList = [
      'http://20.74.136.229/documents/d/guest/group-1686551620',
      'http://20.74.136.229/documents/d/guest/group-1686551558',
      'http://20.74.136.229/documents/d/guest/group-1686551514',
    ];
    state = state.copyWith(
      companyList: AsyncData(
        List.generate(companyList.length, (index) => companyList[index])
            .toList(),
      ),
    );
  }

  Future<void> getCompanyManagement() async {
    final param = ParametersModel(
      nestedFields: 'resdient',
    );
    final result = await DixelsSDK.instance.companyManagementServices
        .getPageDataWithEither(
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
