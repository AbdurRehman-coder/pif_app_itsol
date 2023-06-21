import 'package:dixels_sdk/common/models/parameters_model.dart';
import 'package:dixels_sdk/dixels_sdk.dart';
import 'package:dixels_sdk/features/commerce/visit/models/visit_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/generated/l10n.dart';
import 'package:pif_flutter/helpers/filter_utils.dart';
import 'package:pif_flutter/ui/visit/visit_list/model/visit_model.dart';
import 'package:pif_flutter/ui/visit/visit_list/model/visitor_status_model.dart';
import 'package:pif_flutter/ui/visit/visit_list/state/visit_list_state.dart';

final visitListProvider =
    StateNotifierProvider.autoDispose<VisitListNotifier, VisitListState>((ref) {
  return VisitListNotifier(ref: ref);
});

class VisitListNotifier extends StateNotifier<VisitListState> {
  VisitListNotifier({required this.ref}) : super(VisitListState.initial()) {
    _initData();
  }

  late TextEditingController searchVisitController;
  List<VisitsModel> allVisitsData = <VisitsModel>[];
  final Ref ref;

  void _initData() {
    searchVisitController = TextEditingController();
    final lstStatus = <VisitorStatusModel>[];
    lstStatus.add(VisitorStatusModel(S.current.upComing, true));
    lstStatus.add(VisitorStatusModel(S.current.history, false));

    state = state.copyWith(lstStatus: lstStatus);
    getVisits();
  }

  void updateStatusList(int index) {
    final lstData = state.lstStatus.toList();
    for (final item in lstData) {
      item.isSelected = false;
    }

    final data = lstData[index];
    data.isSelected = true;

    if (data.title == 'Upcoming') {
      state = state.copyWith(allVisitsModel: AsyncData(allVisitsData));
    } else {
      state = state.copyWith(allVisitsModel: const AsyncData(<VisitsModel>[]));
    }

    state = state.copyWith(lstStatus: lstData);
  }

  Future<void> getVisits() async {
    allVisitsData.clear();
    state = state.copyWith(allVisitsModel: const AsyncLoading());
    final featureList = <Future<dynamic>>[];
    final result = await DixelsSDK.visitService.getPageData(
      fromJson: VisitModel.fromJson,
      params: ParametersModel(sort: 'dateCreated:desc'),
    );
    if (result?.items != null) {
      for (final visit in result!.items!) {
        featureList.add(
          DixelsSDK.visitService
              .getVisitorsForVisit(
            visitorId: visit.id,
          ).then((getVisitors) {
            if (getVisitors.isRight()) {
              final visitor = getVisitors.getRight()?.items ?? [];
              allVisitsData.add(
                VisitsModel(
                  id: visit.id,
                  startDateTimeVisit: visit.visitStartDate ?? DateTime.now(),
                  endDateTimeVisit: visit.visitStartDate ?? DateTime.now(),
                  visitModel: visitor,
                ),
              );
            }
          }),
        );
      }
    }
    await Future.wait<dynamic>(featureList);
    state = state.copyWith(allVisitsModel: AsyncData(allVisitsData));
  }
}
