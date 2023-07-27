import 'package:collection/collection.dart';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/ui/drinks/index.dart';
import 'package:pif_flutter/ui/drinks/widget/product_sup_option.dart';

class ProductOptions extends StatefulWidget {
  const ProductOptions({required this.drinkOptions, super.key});

  final List<Options> drinkOptions;

  @override
  State<ProductOptions> createState() => _ProductOptionsState();
}

class _ProductOptionsState extends State<ProductOptions> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final notifier = ref.read(drinksProvider.notifier);
        return SizedBox(
          height: 35.h,
          child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, index) {
              final drinkOption = widget.drinkOptions[index];
              if (drinkOption
                  .productOptionsModel.productOptionValues!.isNotEmpty) {
                final selectedValueOption =
                    drinkOption.valueOptionModel.firstWhereOrNull(
                  (valueOptionModel) => valueOptionModel.valueOptionSelected,
                );
                final valueOptionKey =
                    selectedValueOption?.valueOptionKey ?? '';
                return CustomPopupMenu(
                  controller: drinkOption.customPopupMenuController,
                  enablePassEvent: false,
                  showArrow: false,
                  menuBuilder: () => Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 15.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      color: whiteColor,
                      boxShadow: const [
                        BoxShadow(
                          color: grayE3,
                          spreadRadius: 1,
                          offset: Offset(0, 1),
                        )
                      ],
                      borderRadius: BorderRadius.all(
                        Radius.circular(25.r),
                      ),
                    ),

                    /// Drink add to cart sub options
                    child: ProductSubOption(
                      reBuild: () {
                        setState(() {});
                      },
                      drinkOption: widget.drinkOptions[index],
                      drinksNotifier: notifier,
                    ),
                  ),
                  barrierColor: Colors.transparent,
                  pressType: PressType.longPress,
                  position: PreferredPosition.top,
                  child: InkWell(
                    onTap: () {
                      drinkOption.customPopupMenuController.showMenu();
                      setState(() {});
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color:
                            drinkOption.customPopupMenuController.menuIsShowing
                                ? secondary
                                : drinkOption.isOptionSelect
                                    ? secondary
                                    : grayBgColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20.r),
                        ),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.h),
                      child: Text(
                        '$valueOptionKey ${drinkOption.productOptionsModel.name ?? ''}',
                        style: Style.commonTextStyle(
                          color: drinkOption
                                  .customPopupMenuController.menuIsShowing
                              ? whiteColor
                              : drinkOption.isOptionSelect
                                  ? whiteColor
                                  : expireStatusColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
            separatorBuilder: (_, index) {
              return SizedBox(width: 8.w);
            },
            itemCount: widget.drinkOptions.length,
          ),
        );
      },
    );
  }
}
