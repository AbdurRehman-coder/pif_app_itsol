import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
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
    return SizedBox(
      height: 29.h,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          final drinkOption = widget.drinkOptions[index];
          return CustomPopupMenu(
            controller: drinkOption.customPopupMenuController,
            enablePassEvent: false,
            showArrow: false,
            menuBuilder: () => Container(
              padding: EdgeInsets.symmetric(
                horizontal: 15.w,
                vertical: 4.h,
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
              child: ProductSubOption(
                reBuild: () {
                  setState(() {});
                },
                drinkOption: widget.drinkOptions[index],
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
                  color: drinkOption.customPopupMenuController.menuIsShowing
                      ? dayTextColor
                      : drinkOption.isOptionSelect
                          ? primaryColor
                          : grayF5,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.r),
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                child: Text(
                  drinkOption.productOptionsModel.name ?? '',
                  style: Style.commonTextStyle(
                    color: drinkOption.customPopupMenuController.menuIsShowing
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
        },
        separatorBuilder: (_, index) {
          return SizedBox(width: 8.w);
        },
        itemCount: widget.drinkOptions.length,
      ),
    );
  }
}
