import 'dart:async';

import 'package:dixels_sdk/dixels_sdk.dart';
import 'package:dixels_sdk/features/commerce/orders/model/orders_model.dart';
import 'package:dixels_sdk/features/commerce/support/model/support_ticket_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/message/progress_dialog.dart';
import 'package:pif_flutter/common/shared/message/success_message.dart';
import 'package:pif_flutter/common/shared/message/toast_message.dart';
import 'package:pif_flutter/database/settings.dart';
import 'package:pif_flutter/helpers/common_utils.dart';
import 'package:pif_flutter/penguin/model/user_location.dart';
import 'package:pif_flutter/penguin/penguin_service.dart';
import 'package:pif_flutter/ui/dashboard/model/actions_model.dart'
    as action_model;
import 'package:pif_flutter/ui/dashboard/state/dashboard_state.dart';
import 'package:pif_flutter/ui/drinks/method/check_store_time.dart';
import 'package:pif_flutter/ui/drinks/model/available_time.dart';
import 'package:pif_flutter/routes/routes.dart';
import 'package:pif_flutter/ui/support_and_service/add_ticket/model/add_ticket_model.dart';


final dashboardProvider =
    StateNotifierProvider.autoDispose<DashboardNotifier, DashboardState>((ref) {
  return DashboardNotifier(ref: ref);
});

class DashboardNotifier extends StateNotifier<DashboardState> {
  DashboardNotifier({required this.ref}) : super(DashboardState.initial()) {
    _initData();
  }

  final Ref ref;
  bool isShowPopup = true;
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

  Future<void> initPenguin(BuildContext context) async {
    await CommonUtils.checkPermission();
    final result = await PenguinApiService.initializePenguin;
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      final currentLocation = await PenguinApiService.getCurrentLocation;
      if (currentLocation != null && currentLocation.isNotEmpty) {
        final point = currentLocation.split('_');
        final floorId = point[1];
        final xPos = point[2];
        final yPos = point[3];
        print('Floor Id --------$floorId');
        print('X Position--------$xPos');
        print('Y Position--------$yPos');

        final location = UserLocation(floorId: floorId, xPos: xPos, yPos: yPos);
        Settings.userLocation = location;
        final message = 'User Location Found ---- X Pos : $xPos  Y Pos : $yPos';
        if (isShowPopup) {
          alertMessage(
            errorMessage: message,
            context: context,
            statusEnum: AlertStatusEnum.success,
          );
          isShowPopup = false;
        }
      }
    });
  }

  Future<void> closeVideoFun({required void Function() onTap}) async {
    state = state.copyWith(closeVideo: true);
    onTap();
    Future.delayed(
      const Duration(seconds: 1),
      () => state = state.copyWith(closeVideo: false),
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

    final xPos =
        Settings.userLocation != null ? Settings.userLocation!.xPos : 0;
    final yPos =
        Settings.userLocation != null ? Settings.userLocation!.yPos : 0;

    final requestModel = {
      'categoryId': '180101',
      'subCategoryId': '200984',
      'description':
          '[${data!.name}] is around [$xPos, $yPos] and requesting immediate support',
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

    final xPos =
        Settings.userLocation != null ? Settings.userLocation!.xPos : 0;
    final yPos =
        Settings.userLocation != null ? Settings.userLocation!.yPos : 0;

    final requestModel = {
      'categoryId': '180104',
      'subCategoryId': '200995',
      'description':
          '[${data!.name}] is around [$xPos, $yPos] and requesting immediate support',
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

  void onTapServices({
    required String type,
    String? categoryId,
    String? subCategoryId,
  }) {
    switch (type) {
      case 'QR Booking':
        closeVideoFun(
          onTap: () => AppRouter.pushNamed(Routes.bookingScannerScreen),
        );
        break;
      case 'Support':
        AppRouter.pushNamed(
          Routes.addOrEditTicketScreen,
          args: AddTicketModel(
            idSelectedCategory: categoryId,
          ),
        );
        break;
      case 'Photography':
        closeVideoFun(
          onTap: () => AppRouter.pushNamed(
            Routes.addOrEditTicketScreen,
            args: AddTicketModel(
              idSelectedCategory: categoryId,
              isSelectedSubCategory: subCategoryId,
            ),
          ),
        );
        break;
      case 'Invite Visitors':
        closeVideoFun(
          onTap: () => AppRouter.pushNamed(
            Routes.inviteVisitorScreen,
            args: [true, true, null],
          ),
        );
        break;
      case 'New Joiner':
        closeVideoFun(
          onTap: () => AppRouter.pushNamed(
            Routes.addOrEditTicketScreen,
            args: AddTicketModel(
              idSelectedCategory: categoryId,
            ),
          ),
        );
        break;
      case 'Logistics':
        closeVideoFun(
          onTap: () => AppRouter.pushNamed(
            Routes.addOrEditTicketScreen,
            args: AddTicketModel(
              idSelectedCategory: categoryId,
            ),
          ),
        );
        break;
      case 'Creatives':
        closeVideoFun(
          onTap: () => AppRouter.pushNamed(
            Routes.addOrEditTicketScreen,
            args: AddTicketModel(
              idSelectedCategory: categoryId,
            ),
          ),
        );
        break;
      case 'Booking':
        closeVideoFun(
          onTap: () => AppRouter.pushNamed(Routes.spaceBookingScreen),
        );
        break;
    }
  }
}
