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
                    item.imageUrl,
                    fit: BoxFit.fitHeight,
                    width: 171.w,
                    height: 147.h,
                  ),
                ),
              ),
              if (true)
                Positioned(
                  // top: 8.w,
                  right: 0.w,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
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
                // top: 8.w,
                right: 8.w,
                bottom: 8,
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
              ),
            ],
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
