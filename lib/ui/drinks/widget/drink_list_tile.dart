import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/ui/drinks/index.dart';
import 'package:pif_flutter/ui/drinks/widget/increase_decreas_widget.dart';

class DrinkListTile extends StatelessWidget {
  const DrinkListTile({
    required this.item,
    required this.notifier,
    required this.provider,
    super.key,
  });

  final DrinksNotifier notifier;
  final DrinksState provider;
  final DrinkModel item;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 3.w),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: const [
          BoxShadow(
            color: grayF0,
            blurRadius: 1,
            offset: Offset(3, 4), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          ProductImage(
            url: item.imageUrl,
            withFree: true,
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.drinkTitle ?? '',
                  style: Style.commonTextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w400,
                    color: blackColor,
                  ),
                ),
                SizedBox(height: 3.h),
                Row(
                  children: [
                    SvgPicture.asset(Assets.fire),
                    SizedBox(width: 7.w),
                    Text(
                      item.calories ?? '',
                      style: Style.commonTextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: grayTextColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5.h),
                Align(
                  alignment: Alignment.bottomRight,
                  child: SizedBox(
                    height: 35.h,
                    child: item.count! >= 1
                        ? IncreaseDecreaseWidget(
                            item: item,
                            notifier: notifier,
                          )
                        : ElevatedButton(
                            onPressed: () {
                              if (!provider.storeClosed) {
                                if (provider.lstCarts.isNotEmpty) {
                                  notifier.addItemToCart(
                                    item: item,
                                    context: context,
                                  );
                                } else {
                                  item.count = 1;
                                  showOrderCartAndDetails(
                                    context: context,
                                    drinkModel: item,
                                  );
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: provider.storeClosed
                                  ? primaryDisabledColor
                                  : primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                            ),
                            child: Text(
                              provider.lstCarts.isNotEmpty
                                  ? S.current.addToCart
                                  : S.current.order,
                              style: Style.commonTextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: whiteColor,
                              ),
                            ),
                          ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
