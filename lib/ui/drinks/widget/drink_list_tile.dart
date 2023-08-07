import 'package:flutter/material.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/ui/drinks/index.dart';

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
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28.r),
            boxShadow: const [
              BoxShadow(
                color: grayF0,
                blurRadius: 1,
              ),
            ],
          ),
          child: Material(
            elevation: 5,
            borderRadius: BorderRadius.all(
              Radius.circular(28.r),
            ),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(28.r),
                  child: Container(
                    color: grayF0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network(
                        item.imageUrl,
                        fit: BoxFit.fitHeight,
                        width: 171.w,
                        height: 147.h,
                      ),
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
                Positioned(
                  right: 8.w,
                  bottom: 8,
                  child: Row(
                    children: [
                      if (item.count! <= 0 || provider.lstCarts.isEmpty)
                        const SizedBox()
                      else
                        InkWell(
                          onTap: () {
                            notifier.removeDrinks(item: item);
                          },
                          child: Container(
                            width: 33.w,
                            height: 33.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: primaryDarkColor,
                              border: Border.all(
                                color: primaryColor,
                              ),
                            ),
                            child: Icon(
                              Icons.remove,
                              color: whiteColor,
                              size: 20.spMin,
                            ),
                          ),
                        ),
                      SizedBox(width: 19.w),
                      if (item.count! <= 0 || provider.lstCarts.isEmpty)
                        const SizedBox()
                      else
                        Container(
                          width: 43.w,
                          height: 32.h,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.r),
                            ),
                          ),
                          child: Text(
                            item.count == 0 ? '1' : item.count.toString(),
                            style: Style.commonTextStyle(
                              color: blackColor,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      SizedBox(width: 19.w),
                      InkWell(
                        onTap: () {
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
                        child: Container(
                          padding: EdgeInsets.all(4.w),
                          decoration: BoxDecoration(
                            color: primaryDarkColor,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: greenBorderColor,
                              width: 1,
                            ),
                          ),
                          child: const Icon(
                            Icons.add,
                            color: whiteColor,
                          ),
                        ),
                      ).visibility(visible: !provider.storeClosed),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: size.height * 0.01),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              item.drinkTitle ?? '',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
                color: blackColor,
              ),
            ),
            SizedBox(height: size.height * 0.005),
            Row(
              children: [
                Image.asset(
                  Assets.flatIconFire,
                  scale: 35,
                ),
                SizedBox(width: 3.w),
                Text(
                  item.calories ?? '',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: grayTextColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
