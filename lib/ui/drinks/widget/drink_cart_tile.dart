import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/ui/drinks/index.dart';
import 'package:pif_flutter/ui/drinks/widget/increase_decreas_widget.dart';

class DrinkCartTile extends StatelessWidget {
  const DrinkCartTile({
    required this.notifier,
    this.item,
    super.key,
  });

  final DrinkModel? item;
  final DrinksNotifier notifier;

  @override
  Widget build(BuildContext context) {
    if (item != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ProductImage(
                url: item!.imageUrl,
                withFree: true,
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item!.drinkTitle ?? '',
                      style: Style.commonTextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                        color: blackColor,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Row(
                      children: [
                        SvgPicture.asset(Assets.fire),
                        SizedBox(width: 7.w),
                        Text(
                          item!.calories ?? '',
                          style: Style.commonTextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: grayTextColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    IncreaseDecreaseWidget(
                      item: item!,
                      notifier: notifier,
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (item!.optionList!.isNotEmpty) ...[
            SizedBox(
              height: 16.h,
            ),
            ProductOptions(
              drinkOptions: item!.optionList ?? [],
            ),
          ]
        ],
      );
    } else {
      return const SizedBox();
    }
  }
}
