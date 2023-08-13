import 'package:dixels_sdk/features/commerce/booking/model/deliver_space_model.dart';
import 'package:dixels_sdk/features/commerce/products/models/category_model.dart';
import 'package:dixels_sdk/features/content/structure_content/model/structure_content_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/ui/drinks/model/drink_model.dart';

part 'drinks_state.freezed.dart';

@freezed
class DrinksState with _$DrinksState {
  const factory DrinksState({
    required List<CategoryModel> lstCategory,
    required AsyncValue<List<DrinkModel>> lstDrinks,
    required AsyncValue<List<DrinkModel>> allDrinks,
    required List<DrinkModel> lstCarts,
    required AsyncValue<StructureContentModel> structureContent,
    required bool storeClosed,
    required bool isSelectedPinOrder,
    required int drinkNoteCharCount,
    required DeliverySpaceModel? deliveryLocation,
  }) = _DrinksState;

  factory DrinksState.initial() => const DrinksState(
        lstCategory: <CategoryModel>[],
        lstDrinks: AsyncLoading(),
        allDrinks: AsyncLoading(),
        lstCarts: <DrinkModel>[],
        structureContent: AsyncLoading(),
        storeClosed: false,
        isSelectedPinOrder: false,
        drinkNoteCharCount: 0,
        deliveryLocation: null,
      );
}
