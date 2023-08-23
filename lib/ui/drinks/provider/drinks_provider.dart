import 'dart:convert';

import 'package:dixels_sdk/dixels_sdk.dart';
import 'package:dixels_sdk/features/commerce/booking/model/deliver_space_model.dart';
import 'package:dixels_sdk/features/commerce/orders/model/orders_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:navigation_history_observer/navigation_history_observer.dart';
import 'package:pif_flutter/common/shared/message/progress_dialog.dart';
import 'package:pif_flutter/common/shared/message/slider_success_message.dart';
import 'package:pif_flutter/common/shared/message/toast_message.dart';
import 'package:pif_flutter/database/settings.dart';
import 'package:pif_flutter/generated/l10n.dart';
import 'package:pif_flutter/routes/app_router.dart';
import 'package:pif_flutter/routes/routes.dart';
import 'package:pif_flutter/ui/dashboard/provider/dashboard_provider.dart';
import 'package:pif_flutter/ui/drinks/method/check_store_time.dart';
import 'package:pif_flutter/ui/drinks/model/drink_model.dart';
import 'package:pif_flutter/ui/drinks/model/drinks_oprions.dart';
import 'package:pif_flutter/ui/drinks/model/order_request_model.dart';
import 'package:pif_flutter/ui/drinks/popup/drink_cart_and_details.dart';
import 'package:pif_flutter/ui/drinks/state/drinks_state.dart';

final drinksProvider = StateNotifierProvider.autoDispose<DrinksNotifier, DrinksState>((ref) {
  return DrinksNotifier(ref: ref);
});

class DrinksNotifier extends StateNotifier<DrinksState> {
  DrinksNotifier({required this.ref}) : super(DrinksState.initial()) {
    _initData();
  }

  final Ref ref;

  void _initData() {
    searchController = TextEditingController();
    notesController = TextEditingController();
    final notifier = ref.read(dashboardProvider.notifier);
    notifier.getStoreInformation();
    _getCategories();
  }

  late TextEditingController searchController;
  late TextEditingController notesController;
  List<DrinkModel> allDrinks = <DrinkModel>[];
  List<DrinkModel> selectedCatDrinks = <DrinkModel>[];
  FocusNode searchFocusNode = FocusNode();

  bool checkDateStart(DateTime dateTime) {
    final dateTimeNow = DateTime.now();
    if (dateTime.hour != dateTimeNow.hour) {
      return dateTimeNow.hour < dateTime.hour;
    } else {
      return dateTimeNow.minute < dateTime.minute;
    }
  }

  bool checkDateEnd(DateTime dateTime) {
    final dateTimeNow = DateTime.now();
    if (dateTime.hour != dateTimeNow.hour) {
      return dateTimeNow.hour > dateTime.hour && dateTimeNow.minute > dateTime.minute;
    } else {
      return dateTimeNow.minute > dateTime.minute;
    }
  }

  Future<void> _getDrinks() async {
    final result = await DixelsSDK.instance.productService.getProductsByChannelAsync(
      channelId: '147240',
      accountId: '148293',
    );

    if (result != null && result.items != null) {
      final lstDrinks = <DrinkModel>[];
      for (final element in result.items!) {
        if (element.categories != null && element.categories!.isNotEmpty) {
          final cateId = element.categories![0].id;
          lstDrinks.add(
            DrinkModel(
              id: element.id,
              categoryId: cateId,
              drinkImage: element.urlImage,
              drinkTitle: element.name,
              calories: '${element.expando!.calories} cal',
              count: 0,
              skus: element.skus?.first.id,
              duration: '5 min',
              drinkOption: element.productOptions,
            ),
          );
        }
      }

      allDrinks = lstDrinks;
      state = state.copyWith(lstDrinks: AsyncData(lstDrinks));
      updateCategory(index: 0);
    }
  }

  Future<void> _getCategories() async {
    final result = await DixelsSDK.instance.productService.getCategories();
    if (result != null) {
      state = state.copyWith(lstCategory: result.items!);
    }
    await _getDrinks();
  }

  void updateCategory({required int index}) {
    final lstData = state.lstCategory;
    for (final element in lstData) {
      element.isSelected = false;
    }
    lstData[index].isSelected = true;

    final lstDrink = allDrinks.where((element) => element.categoryId == int.parse(lstData[index].id!)).toList();

    selectedCatDrinks = lstDrink;
    state = state.copyWith(lstDrinks: AsyncData(lstDrink));
    state = state.copyWith(lstCategory: lstData);
  }

  void searchData(String searchTxt) {
    final lstData = allDrinks
        .where(
          (element) => element.drinkTitle!.toLowerCase().contains(searchTxt.toLowerCase()),
        )
        .toList();

    state = state.copyWith(allDrinks: AsyncData(lstData));
  }

  void addDrinks({required DrinkModel item}) {
    item.count = item.count! + 1;
    updateDrinkList(item: item);
  }

  void removeDrinks({required DrinkModel item, bool isFromCartDetail = false}) {
    if (state.lstCarts.isEmpty) {
      final navigation = NavigationHistoryObserver().history.last;
      if (navigation.settings.name == Routes.drinkDetailsScreen && item.count == 1) {
        return;
      }
    }
    item.count = item.count! - 1;

    if (item.count == 0) {
      final lstCart = state.lstCarts.toList();
      if (lstCart.length == 1 && isFromCartDetail == true) {
        AppRouter.pop();
      }
      lstCart.remove(item);
      state = state.copyWith(lstCarts: lstCart);
    }
    updateDrinkList(item: item);
  }

  void updateDrinkList({required DrinkModel item}) {
    final lstData = state.lstDrinks.value;
    final index = lstData!.indexOf(item);
    if (index != -1) {
      lstData[index] = item;
    }

    state = state.copyWith(lstDrinks: AsyncData(lstData));
  }

  void drinkBagTap({required BuildContext context}) {
    showOrderCartAndDetails(
      context: context,
    );
  }

  void hideAllSubOption({required DrinkModel drinkModel}) {
    if (drinkModel.drinkOption!.isNotEmpty) {
      for (final options in drinkModel.optionList!) {
        options.customPopupMenuController.hideMenu();
      }
    }
  }

  void addItemToCart({
    required DrinkModel item,
    required BuildContext context,
    bool withOrder = false,
  }) {
    if (item.count == 0) {
      item.count = 1;
    }

    final lstCart = state.lstCarts.toList();

    /// add to cart only if it is not already contain in the cartList
    /// if item is not already contain in the list
    if (!lstCart.contains(item)) {
      lstCart.add(item);
    } else {
      item.count = item.count! + 1;
    }

    state = state.copyWith(lstCarts: lstCart);
    if (withOrder) {
      orderNow(context: context);
    } else {
      updateDrinkList(item: item);
    }
  }

  Future<void> orderNow({required BuildContext context}) async {
    final appProgressDialog = AppProgressDialog(context: context);
    await appProgressDialog.start();
    final notifier = ref.read(dashboardProvider.notifier);
    final availableTime = await notifier.getStoreInformation();
    if (checkStoreStatus(
      openTime: availableTime.storeStartTime,
      closedTime: availableTime.storeEndTime,
    )) {
      final itemCart = state.lstCarts.toList().map(
        (itemInCart) {
          final item = itemInCart.optionList!.where((element) => element.isOptionSelect).toList().map(
            (e) {
              final listString = e.valueOptionModel.where((element) => element.valueOptionSelected).first.valueOptionKey;
              return DrinksOptions(
                key: e.productOptionsModel.key!,
                required: false,
                value: [listString],
              );
            },
          ).toList();
          return OrderItem(
            options: item.isNotEmpty ? jsonEncode(item) : '',
            quantity: itemInCart.count!,
            skuId: itemInCart.skus!,
            productId: itemInCart.id!,
          );
        },
      ).toList();
      final orderParam = OrderRequestModel(
        accountId: 148293,
        channelId: 147240,
        currencyCode: 'USD',
        printedNote: notesController.text,
        orderItems: itemCart,
        orderStatus: 2,
      );

      if (state.deliveryLocation != null) {
        if (state.deliveryLocation!.spaceType == 'Room') {
          orderParam.roomId =
              (state.deliveryLocation!.id != null && state.deliveryLocation!.id!.isNotEmpty) ? int.parse(state.deliveryLocation!.id!) : 0;
        } else if (state.deliveryLocation!.spaceType == 'Desk') {
          orderParam.deskId =
              (state.deliveryLocation!.id != null && state.deliveryLocation!.id!.isNotEmpty) ? int.parse(state.deliveryLocation!.id!) : 0;
        } else {
          orderParam.areaId =
              (state.deliveryLocation!.id != null && state.deliveryLocation!.id!.isNotEmpty) ? int.parse(state.deliveryLocation!.id!) : 0;
        }
      }

      if (state.isSelectedPinOrder == true) {
        Settings.orderRequestModel = orderParam;
      }
      final jsonRequest = orderParam.toJson();
      jsonRequest.removeWhere((key, value) => value == null);
      await appProgressDialog.stop();
      showSuccessSliding(
        context: context,
        titleText: S.current.drinkOrder,
        navigateAfterEndTime: () {
          Future.delayed(Duration.zero, () async {
            await appProgressDialog.start();
            final result = await DixelsSDK.instance.ordersService.postPageDataWithEither(
              reqModel: jsonRequest,
              fromJson: OrdersModel.fromJson,
            );
            if (result.isRight()) {
              await appProgressDialog.stop();
              alertMessage(
                errorMessage: S.current.drinkOrderSuccess,
                context: context,
                statusEnum: AlertStatusEnum.success,
              );
              clearData();
              AppRouter.popUntil(Routes.dashboardScreen);
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
      state = state.copyWith(isSelectedPinOrder: false);
      state = state.copyWith(drinkNoteCharCount: 0);
      notesController.clear();
    } else {
      await appProgressDialog.stop();
      alertMessage(
        errorMessage: S.current.storeNotAvailable,
        context: context,
      );
      AppRouter.popUntil(Routes.dashboardScreen);
    }
  }

  void clearData() {
    state = state.copyWith(lstCarts: <DrinkModel>[]);

    for (final item in allDrinks) {
      item.count = 0;
    }

    final selectedCategory = state.lstCategory.firstWhere((element) => element.isSelected! == true);

    final lstDrink = allDrinks
        .where(
          (element) => element.categoryId == int.parse(selectedCategory.id!),
        )
        .toList();

    state = state.copyWith(lstDrinks: AsyncData(lstDrink));
    notesController.clear();
  }

  void updatePinOrderQuickActions({required bool value}) {
    state = state.copyWith(isSelectedPinOrder: value);
  }

  void updateTypedCharacterCount(String newText) {
    state = state.copyWith(drinkNoteCharCount: newText.length);
  }

  void updateValueOption({
    required Options options,
    required ValueOptions valueOptions,
  }) {
    options.valueOptionModel.any((element) => element.valueOptionSelected = false);
    options.valueOptionModel.where((value) => value == valueOptions).first.valueOptionSelected = true;
  }

  void updateDeliveryLocation({required DeliverySpaceModel spaceModel}) {
    state = state.copyWith(deliveryLocation: spaceModel);
  }
}
