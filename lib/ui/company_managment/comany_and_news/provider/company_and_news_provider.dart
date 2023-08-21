import 'package:dixels_sdk/common/models/parameters_model.dart';
import 'package:dixels_sdk/dixels_sdk.dart';
import 'package:dixels_sdk/features/commerce/company_managment/model/company_management_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/ui/company_managment/comany_and_news/state/company_and_news_state.dart';

final companyAndNewsProvider = StateNotifierProvider.autoDispose<CompanyAndNewsNotifier, CompanyAndNewsState>((ref) {
  return CompanyAndNewsNotifier(ref: ref);
});

class CompanyAndNewsNotifier extends StateNotifier<CompanyAndNewsState> {
  CompanyAndNewsNotifier({required this.ref}) : super(CompanyAndNewsState.initial()) {
    _initData();
  }

  final Ref ref;
  late ScrollController scrollController;
  int? page = 1;
  int? lastPage = 1;
  List<CompanyManagementModel> allListData = <CompanyManagementModel>[];

  void loadMore() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      state = state.copyWith(isLoading: true);

      getCompanyManagement();
    }
  }

  void _initData() {
    scrollController = ScrollController();
    scrollController.addListener(loadMore);
  }

  Future<void> getCompanyManagement() async {
    final param = ParametersModel(
      nestedFields: 'residents',
    );

    if (lastPage! < page!) {
      state = state.copyWith(isLoading: false);
      return;
    }

    param.page = page.toString();
    final result = await DixelsSDK.instance.companyManagementServices.getPageDataWithEither(
      fromJson: CompanyManagementModel.fromJson,
      params: param,
    );
    if (result.isRight()) {
      lastPage = result.getRight()!.lastPage;
      final listData = state.companyManagementList.value != null ? state.companyManagementList.value!.toList() : <CompanyManagementModel>[];
      listData.addAll(result.getRight()!.items!);
      page = page! + 1;
      state = state.copyWith(
        companyManagementList: AsyncData(
          listData,
        ),
      );
    } else {
      state = state.copyWith(
        companyManagementList: const AsyncError(
          '',
          StackTrace.empty,
        ),
      );
    }
  }
}
