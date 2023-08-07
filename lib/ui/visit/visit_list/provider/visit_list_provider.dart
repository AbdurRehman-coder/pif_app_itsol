import 'package:dixels_sdk/common/models/parameters_model.dart';
import 'package:dixels_sdk/dixels_sdk.dart';
import 'package:dixels_sdk/features/commerce/visit/models/cancel_visit_param.dart';
import 'package:dixels_sdk/features/commerce/visit/models/visit_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/extensions/date_time_extension.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/message/progress_dialog.dart';
import 'package:pif_flutter/common/shared/message/toast_message.dart';
import 'package:pif_flutter/routes/routes.dart';
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
  List<VisitModel> allVisitsDataUpcoming = <VisitModel>[];
  List<VisitModel> allVisitsDataHistory = <VisitModel>[];
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
      allVisitsDataUpcoming.sort((a, b) {
        return a.visitStartDate!.compareTo(b.dateCreated!);
      });
      state = state.copyWith(allVisitsModel: AsyncData(allVisitsDataUpcoming));
    } else {
      allVisitsDataHistory.sort((a, b) {
        return a.visitStartDate!.compareTo(b.dateCreated!);
      });
      state = state.copyWith(allVisitsModel: AsyncData(allVisitsDataHistory));
    }

    state = state.copyWith(lstStatus: lstData);
  }

  Future<void> getVisits() async {
    allVisitsDataUpcoming.clear();
    state = state.copyWith(allVisitsModel: const AsyncLoading());
    final result = await DixelsSDK.instance.visitService.getPageData(
      fromJson: VisitModel.fromJson,
      params: ParametersModel(
        sort: 'dateCreated:desc',
        restrictFields: 'actions',
        nestedFields: 'visitors',
      ),
    );
    allVisitsDataUpcoming = result!.items!
        .where(
          (element) =>
              element.visitEndDate!.isAfterNow &&
              element.state?.key != 'cancelled',
        )
        .toList();
    allVisitsDataHistory = result.items!
        .where(
          (element) =>
              !element.visitEndDate!.isAfterNow ||
              element.state?.key == 'cancelled',
        )
        .toList();

    updateStatusList(
      state.lstStatus.indexWhere((element) => element.isSelected ?? false),
    );
  }

  Future<void> navigateToEditVisit({
    required VisitModel? selectedVisit,
  }) async {
    await Future.delayed(Duration.zero);
    await AppRouter.pushNamed(
      Routes.inviteVisitorScreen,
      args: [false, false, selectedVisit],
    );
  }

  Future<void> cancelVisit({
    required BuildContext context,
    required int visitId,
  }) async {
    final appProgressDialog = AppProgressDialog(context: context);
    await appProgressDialog.start();
    final result = await DixelsSDK.instance.visitService.cancelVisit(
      visitId: visitId,
      cancelVisitParam: CancelVisitParam(
        visitState: 'cancelled',
      ),
    );
    await appProgressDialog.stop();
    if (result.isRight()) {
      Future.delayed(Duration.zero, AppRouter.pop);
      await getVisits();
      alertMessage(
        errorMessage: S.current.editInvitationSuccessfully,
        context: context,
        statusEnum: AlertStatusEnum.success,
      );
    } else {
      alertMessage(
        errorMessage: result.getLeft().message,
        context: context,
      );
    }
  }
}
