import 'package:dixels_sdk/dixels_sdk.dart';
import 'package:dixels_sdk/features/commerce/visit/models/visit_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/generated/l10n.dart';
import 'package:pif_flutter/ui/visit_list/model/visitor_status_model.dart';
import 'package:pif_flutter/ui/visit_list/state/visit_list_state.dart';

final visitListProvider = StateNotifierProvider.autoDispose<VisitListNotifier, VisitListState>((ref) {
  return VisitListNotifier(ref: ref);
});

class VisitListNotifier extends StateNotifier<VisitListState> {
  VisitListNotifier({required this.ref}) : super(VisitListState.initial()) {
    _initData();
  }

  late TextEditingController searchVisitController;

  List<VisitModel> allVisitData = <VisitModel>[];
  List<String> userVisitor = [
    'Abdulrahman Saleh',
    'Obaida Belal',
    'Slaem Mahmoud',
    'Obaida Belal',
    'Obaida Belal',
    'Obaida Belal',
  ];
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
      state = state.copyWith(allVisits: AsyncData(allVisitData));
    } else {
      state = state.copyWith(allVisits: const AsyncData(<VisitModel>[]));
    }

    state = state.copyWith(lstStatus: lstData);
  }

  Future<void> getVisits() async {
    state = state.copyWith(allVisits: const AsyncLoading());
    state = state.copyWith(loadingData: true);
    await DixelsSDK.visitService.getPageData(fromJson: VisitModel.fromJson).then((result) {
      if (result!.items != null) {
        allVisitData = result.items!;
        state = state.copyWith(allVisits: AsyncData(result.items ?? []));
        state = state.copyWith(loadingData: false);
      }
    });
  }
}
