import 'package:flutter/material.dart';
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
          Container(
            height: 160.h,
            width: double.infinity.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(28.r),
              ),
              border: Border.all(color: grayGradientStart),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Container(
                    height: 171.h,
                    width: 147.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18.r),
                      boxShadow: const [
                        BoxShadow(
                          color: grayF0,
                          blurRadius: 1,
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(28.r),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.network(
                              item!.imageUrl,
                              fit: BoxFit.fitHeight,
                              width: 151.w,
                              height: 147.h,
                            ),
                          ),
                        ),
                        if (true)
                          Positioned(
                            // top: 8.w,
                            right: 0.w,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 10.h,
                              ),
                              decoration: BoxDecoration(
                                color: whiteColor,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(28.r),
                                  topRight: Radius.circular(18.r),
                                ),
                              ),
                              child: Text(
                                'Free',
                                style: TextStyle(
                                  color: primaryDarkColor,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 16.h,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SizedBox(
                          height: 16.h,
                        ),
                        Text(
                          item?.drinkTitle ?? '',
                          style: Style.commonTextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                            color: blackColor,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          children: [
                            Image.asset(
                              Assets.flatIconFire,
                              scale: 35,
                            ),
                            SizedBox(width: 2.w),
                            Text(
                              item?.calories ?? '',
                              style: Style.commonTextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: grayTextColor,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        IncreaseDecreaseWidget(
                          item: item!,
                          notifier: notifier,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (item!.optionList!.isNotEmpty) ...[
            SizedBox(
              height: 16.h,
            ),
            ProductOptions(
              drinkOptions: item!.optionList ?? [],
            ),
            SizedBox(
              height: 10.h,
            ),
          ]
        ],
      );
    } else {
      return const SizedBox();
    }
  }
}
