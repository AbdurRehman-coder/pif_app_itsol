import 'dart:convert';

import 'package:dixels_sdk/dixels_sdk.dart';
import 'package:dixels_sdk/features/commerce/carts/models/cart_request_model.dart';
import 'package:dixels_sdk/features/commerce/orders/model/orders_model.dart';
import 'package:dixels_sdk/features/commerce/orders/model/orders_param.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:navigation_history_observer/navigation_history_observer.dart';
import 'package:pif_flutter/common/extensions/date_time_extension.dart';
import 'package:pif_flutter/common/shared/message/progress_dialog.dart';
import 'package:pif_flutter/common/shared/message/success_message.dart';
import 'package:pif_flutter/common/shared/message/toast_message.dart';
import 'package:pif_flutter/generated/l10n.dart';
import 'package:pif_flutter/routes/app_router.dart';
import 'package:pif_flutter/routes/routes.dart';
import 'package:pif_flutter/ui/drinks/method/check_store_time.dart';
import 'package:pif_flutter/ui/drinks/model/available_time.dart';
import 'package:pif_flutter/ui/drinks/model/drink_model.dart';
import 'package:pif_flutter/ui/drinks/model/drinks_oprions.dart';
import 'package:pif_flutter/ui/drinks/popup/drink_cart_and_details.dart';
import 'package:pif_flutter/ui/drinks/state/drinks_state.dart';

final drinksProvider =
    StateNotifierProvider.autoDispose<DrinksNotifier, DrinksState>((ref) {
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
    getStoreInformation();
    _getCategories();
  }

  late TextEditingController searchController;
  List<DrinkModel> allDrinks = <DrinkModel>[];
  List<DrinkModel> selectedCatDrinks = <DrinkModel>[];
  FocusNode searchFocusNode = FocusNode();
  late TextEditingController notesController;

  Future<AvailableTime> getStoreInformation() async {
    final storeInformation =
        await DixelsSDK.instance.structureContentService.getStoreInformation(
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
      return dateTimeNow.hour > dateTime.hour &&
          dateTimeNow.minute > dateTime.minute;
    } else {
      return dateTimeNow.minute > dateTime.minute;
    }
  }

  Future<void> _getDrinks() async {
    final result =
        await DixelsSDK.instance.productService.getProductsByChannelAsync(
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
    searchController.clear();
    searchFocusNode.unfocus();
    final lstData = state.lstCategory;
    for (final element in lstData) {
      element.isSelected = false;
    }
    lstData[index].isSelected = true;

    final lstDrink = allDrinks
        .where((element) => element.categoryId == int.parse(lstData[index].id!))
        .toList();

    selectedCatDrinks = lstDrink;
    state = state.copyWith(lstDrinks: AsyncData(lstDrink));
    state = state.copyWith(lstCategory: lstData);
  }

  void searchData(String searchTxt) {
    final lstData = allDrinks
        .where(
          (element) => element.drinkTitle!
              .toLowerCase()
              .contains(searchTxt.toLowerCase()),
        )
        .toList();

    state = state.copyWith(allDrinks: AsyncData(lstData));
  }

  void addDrinks({required DrinkModel item}) {
    item.count = item.count! + 1;
    updateDrinkList(item: item);
  }

  void removeDrinks({required DrinkModel item}) {
    if (state.lstCarts.isEmpty) {
      final navigation = NavigationHistoryObserver().history.last;
      if (navigation.settings.name == Routes.drinkDetailsScreen &&
          item.count == 1) {
        return;
      }
    }

    item.count = item.count! - 1;

    if (item.count == 0) {
      final lstCart = state.lstCarts.toList();
      if (lstCart.length == 1) {
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
    lstCart.add(item);

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
    final availableTime = await getStoreInformation();
    if (checkStoreStatus(
      openTime: availableTime.storeStartTime,
      closedTime: availableTime.storeEndTime,
    )) {
      final itemCart = state.lstCarts.toList().map(
            (itemInCart) {
          final item = itemInCart.optionList!
              .where((element) => element.isOptionSelect)
              .toList()
              .map(
                (e) {
              final listString = e.valueOptionModel
                  .where((element) => element.valueOptionSelected)
                  .first
                  .valueOptionKey;
              return DrinksOptions(
                key: e.productOptionsModel.key!,
                required: false,
                value: [listString],
              );
            },
          ).toList();
          return OrderItem(
            options:
            item.isNotEmpty ? jsonEncode(item).replaceAll('"', r'\"') : '',
            quantity: itemInCart.count!,
            skuId: itemInCart.skus!,
            productId: itemInCart.id!,
          );
        },
      ).toList();
      final orderParam = OrdersParam(
        accountId: 148293,
        channelId: 147240,
        currencyCode: 'USD',
        printedNote: notesController.text,
        orderItems: itemCart,
      );
    final result=  await DixelsSDK.instance.ordersService.postPageDataWithEither(
        reqModel: orderParam,
        fromJson: OrdersModel.fromJson,
      );
      if (result.isRight()) {
        await appProgressDialog.stop();
        showSuccessMessage(
          context: context,
          titleText: S.of(context).drinkOrder,
          subTitle: S.of(context).orderByMistake,
          navigateAfterEndTime: () => AppRouter.popUntil(Routes.homeScreen),
        );
        clearData();
      } else {
        await appProgressDialog.stop();
      }
    } else {
      await appProgressDialog.stop();
      errorMessage(
        errorMessage: S.current.storeNotAvailable,
        context: context,
      );
      AppRouter.popUntil(Routes.homeScreen);
    }
  }

  void clearData() {
    state = state.copyWith(lstCarts: <DrinkModel>[]);

    for (final item in allDrinks) {
      item.count = 0;
    }

    final selectedCategory =
        state.lstCategory.firstWhere((element) => element.isSelected! == true);

    final lstDrink = allDrinks
        .where(
          (element) => element.categoryId == int.parse(selectedCategory.id!),
        )
        .toList();

    state = state.copyWith(lstDrinks: AsyncData(lstDrink));
    notesController.clear();
  }

  void updateValueOption({
    required Options options,
    required ValueOptions valueOptions,
  }) {
    options.valueOptionModel
        .any((element) => element.valueOptionSelected = false);
    options.valueOptionModel
        .where((value) => value == valueOptions)
        .first
        .valueOptionSelected = true;
  }
}
