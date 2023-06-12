import 'package:dixels_sdk/dixels_sdk.dart';
import 'package:dixels_sdk/features/commerce/carts/models/cart_request_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:navigation_history_observer/navigation_history_observer.dart';
import 'package:pif_flutter/common/shared/message/progress_dialog.dart';
import 'package:pif_flutter/common/shared/message/success_message.dart';
import 'package:pif_flutter/generated/l10n.dart';
import 'package:pif_flutter/routes/app_router.dart';
import 'package:pif_flutter/routes/routes.dart';
import 'package:pif_flutter/ui/drinks/model/drink_model.dart';
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
  }

  late TextEditingController searchController;
  List<DrinkModel> allDrinks = <DrinkModel>[];
  List<DrinkModel> selectedCatDrinks = <DrinkModel>[];
  FocusNode searchFocusNode = FocusNode();
  late TextEditingController notesController;

  Future<void> getStoreInformation() async {
    await DixelsSDK.structureContentService
        .getStoreInformation(
      webContentId: '147637',
      siteId: '20120',
    )
        .then((storeInformation) {
      state = state.copyWith(structureContent: AsyncData(storeInformation!));
    });
    await _getCategories();
    await _getDrinks();
  }

  Future<void> _getDrinks() async {
    final result = await DixelsSDK.productService.getProductsByChannelAsync(
      channelId: '147240',
      accountId: '148293',
    );
    if (result != null && result.items != null) {
      final lstDrinks = <DrinkModel>[];
      for (final element in result.items!) {
        final cateId = element.categories![0].id;
        lstDrinks.add(
          DrinkModel(
            id: element.id,
            categoryId: cateId,
            drinkImage: element.urlImage,
            drinkTitle: element.name,
            calories: '${element.expando!.calories} cal',
            count: 0,
            duration: '5 min',
            drinkOption: element.productOptions,
          ),
        );
      }

      allDrinks = lstDrinks;
      state = state.copyWith(lstDrinks: AsyncData(lstDrinks));
      updateCategory(index: 0);
    }
  }

  Future<void> _getCategories() async {
    final result = await DixelsSDK.productService.getCategories();
    if (result != null) {
      state = state.copyWith(lstCategory: result.items!);
    }
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

  void addItemToCart({
    required DrinkModel item,
    required BuildContext context,
  }) {
    if (item.count == 0) {
      item.count = 1;
    }

    final lstCart = state.lstCarts.toList();
    lstCart.add(item);

    state = state.copyWith(lstCarts: lstCart);
    updateDrinkList(item: item);
  }

  void addDrinks({required DrinkModel item}) {
    item.count = item.count! + 1;
    updateDrinkList(item: item);
  }

  void removeDrinks({required DrinkModel item}) {
    final navigation = NavigationHistoryObserver().history.last;
    if (navigation.settings.name == Routes.drinkDetailsScreen &&
        state.lstCarts.length == 1 &&
        item.count == 1) {
      return;
    }

    item.count = item.count! - 1;

    if (item.count == 0) {
      final lstCart = state.lstCarts.toList();
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

  Future<void> orderNow(BuildContext context) async {
    final data = state.lstCarts
        .toList()
        .map(
          (e) => CartItems(
            options: '',
            quantity: e.count,
            skuId: 148326,
            productId: e.id,
          ),
        )
        .toList();

    final request = CartRequestModel();
    request.accountId = 148293;
    request.cartItems = data;
    request.currencyCode = 'USD';
    request.notes = <Notes>[
      Notes(
        content: notesController.text,
        restricted: true,
      )
    ];
    final appProgressDialog = AppProgressDialog(context: context);
    await appProgressDialog.start();
    final result = await DixelsSDK.cartService.addCartAsync(
      request: request,
      channelId: '147240',
    );
    if (result != null) {
      await DixelsSDK.cartService
          .checkoutAsync(cartId: result.id.toString())
          .then(
        (value) async {
          await appProgressDialog.stop();
          showSuccessMessage(
            context: context,
            titleText: S.of(context).drinkOrder,
            subTitle: S.of(context).orderByMistake,
            navigateAfterEndTime: () => AppRouter.popUntil(Routes.homeScreen),
          );
        },
      );
      clearData();
    } else {
      await appProgressDialog.stop();
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
}
