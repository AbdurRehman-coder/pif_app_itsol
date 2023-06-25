import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:dixels_sdk/features/commerce/products/models/product_options_model.dart';

class DrinkModel {
  DrinkModel({
    this.id,
    this.categoryId,
    this.drinkImage,
    this.drinkTitle,
    this.calories,
    this.count,
    this.skus,
    this.duration,
    this.drinkOption,
  }) : optionList = drinkOption != null
            ? drinkOption
                .map(
                  (option) => Options(
                    isOptionSelect: false,
                    customPopupMenuController: CustomPopupMenuController(),
                    productOptionsModel: option,
                  ),
                )
                .toList()
            : [];

  int? categoryId;
  int? id;
  String? drinkImage;
  String? drinkTitle;
  String? calories;
  int? count = 0;
  int? skus = 0;
  String? duration;
  List<ProductOptionsModel>? drinkOption;
  List<Options>? optionList;

  String get imageUrl => drinkImage != null
      ? drinkImage!.replaceAll('https://localhost:8080', 'http://20.74.136.229')
      : '';
}

class Options {
  Options({
    required this.isOptionSelect,
    required this.customPopupMenuController,
    required this.productOptionsModel,
  });

  bool isOptionSelect;
  final CustomPopupMenuController customPopupMenuController;
  final ProductOptionsModel productOptionsModel;
}
