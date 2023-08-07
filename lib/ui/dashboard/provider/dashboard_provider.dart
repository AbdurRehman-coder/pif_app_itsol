import 'package:dixels_sdk/dixels_sdk.dart';
import 'package:dixels_sdk/features/commerce/orders/model/orders_model.dart';
import 'package:dixels_sdk/features/commerce/support/model/support_ticket_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/extensions/date_time_extension.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/message/progress_dialog.dart';
import 'package:pif_flutter/common/shared/message/success_message.dart';
import 'package:pif_flutter/common/shared/message/toast_message.dart';
import 'package:pif_flutter/database/settings.dart';
import 'package:pif_flutter/ui/dashboard/model/actions_model.dart'
    as action_model;
import 'package:pif_flutter/ui/dashboard/state/dashboard_state.dart';
import 'package:pif_flutter/ui/drinks/method/check_store_time.dart';
import 'package:pif_flutter/ui/drinks/model/available_time.dart';

final dashboardProvider =
    StateNotifierProvider.autoDispose<DashboardNotifier, DashboardState>((ref) {
  return DashboardNotifier(ref: ref);
});

class DashboardNotifier extends StateNotifier<DashboardState> {
  DashboardNotifier({required this.ref}) : super(DashboardState.initial()) {
    _initData();
  }

  final Ref ref;
  List<String> actionIcon = [
    Assets.coffee1Lottie,
    Assets.coffee2Lottie,
    Assets.coffee3Lottie,
    Assets.coffee3Lottie,
  ];
  AnimationController? animateController;

  void _initData() {
    final actions = List.generate(
      actionIcon.length,
      (index) => action_model.ActionModel(
        actionImage: actionIcon[index],
        actionFunction: () {
          if (index == 0) {}
        },
      ),
    ).toList();
    state = state.copyWith(
      actionList: AsyncData(actions),
    );
  }

  void closeFloatMenu({required AnimationController animationController}) {
    if (animationController.status != AnimationStatus.dismissed) {
      animationController.reverse();
    }
  }

  Future<AvailableTime> getStoreInformation() async {
    final storeInformation = await DixelsSDK.instance.structureContentService
        .getStructureContentByKey(
      webContentId: '147637',
      siteId: '20120',
    );

    state = state.copyWith(structureContent: AsyncData(storeInformation!));
    final storeStartDateTime =
        storeInformation.contentFields![3].contentFieldValue!.data!.getTime;
    final storeEndDateTime =
        storeInformation.contentFields![4].contentFieldValue!.data!.getTime;
    state = state.copyWith(
      storeClosed: !checkStoreStatus(
            openTime: storeStartDateTime,
            closedTime: storeEndDateTime,
          ) ||
          DateTime.now().weekday == DateTime.friday ||
          DateTime.now().weekday == DateTime.saturday,
    );
    return AvailableTime(
      storeStartTime: storeStartDateTime,
      storeEndTime: storeEndDateTime,
    );
  }

  Future<void> orderNow({required BuildContext context}) async {
    if (Settings.orderRequestModel == null) {
      alertMessage(
        errorMessage: S.of(context).noQuickDrinkAvailableMsg,
        context: context,
      );
      return;
    }
    final appProgressDialog = AppProgressDialog(context: context);
    await appProgressDialog.start();

    final availableTime = await getStoreInformation();

    if (checkStoreStatus(
      openTime: availableTime.storeStartTime,
      closedTime: availableTime.storeEndTime,
    )) {
      final orderParam = Settings.orderRequestModel!;

      await appProgressDialog.stop();
      showSuccessMessage(
        context: context,
        titleText: S.of(context).drinkOrder,
        subTitle: S.of(context).orderByMistake,
        navigateAfterEndTime: () {
          Future.delayed(Duration.zero, () async {
            await appProgressDialog.start();
            final result =
                await DixelsSDK.instance.ordersService.postPageDataWithEither(
              reqModel: orderParam.toJson(),
              fromJson: OrdersModel.fromJson,
            );
            if (result.isRight()) {
              await appProgressDialog.stop();
              alertMessage(
                errorMessage: S.current.drinkOrderSuccess,
                context: context,
                statusEnum: AlertStatusEnum.success,
              );
            } else {
              await appProgressDialog.stop();
              alertMessage(
                errorMessage: S.current.somethingWentWrong,
                context: context,
              );
            }
          });
        },
      );
    } else {
      await appProgressDialog.stop();
      alertMessage(
        errorMessage: S.current.storeNotAvailable,
        context: context,
      );
    }
  }

  Future<void> digitalVipSupportAsync({required BuildContext context}) async {
    final data = await DixelsSDK.instance.userDetails;

    final requestModel = {
      'categoryId': '180101',
      'subCategoryId': '200984',
      'description':
          '[${data!.name}] is around [nearest location] and requesting immediate support',
    };
    final appProgress = AppProgressDialog(context: context);
    await appProgress.start();

    final result = await DixelsSDK.instance.supportService.postPageData(
      reqModel: requestModel,
      fromJson: SupportTicketModel.fromJson,
    );
    await appProgress.stop();
    if (result != null) {
      alertMessage(
        errorMessage: S.current.successfullySentRequest,
        context: context,
        statusEnum: AlertStatusEnum.success,
      );
    }
  }

  Future<void> operationalSupportAsync({required BuildContext context}) async {
    final data = await DixelsSDK.instance.userDetails;

    final requestModel = {
      'categoryId': '180104',
      'subCategoryId': '200995',
      'description':
          '[${data!.name}] is around [nearest location] and requesting immediate support',
    };
    final appProgress = AppProgressDialog(context: context);
    await appProgress.start();

    final result = await DixelsSDK.instance.supportService.postPageData(
      reqModel: requestModel,
      fromJson: SupportTicketModel.fromJson,
    );
    await appProgress.stop();
    if (result != null) {
      alertMessage(
        errorMessage: S.current.successfullySentRequest,
        context: context,
        statusEnum: AlertStatusEnum.success,
      );
    }
  }

  Future<void> test({required BuildContext context}) async {
    final appProgressDialog = AppProgressDialog(context: context);
    await appProgressDialog.start();
    await Future.delayed(const Duration(seconds: 2));
    await appProgressDialog.stop();
  }
}
