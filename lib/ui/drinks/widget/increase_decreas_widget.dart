import 'package:flutter/material.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/ui/drinks/index.dart';

class IncreaseDecreaseWidget extends StatelessWidget {
  const IncreaseDecreaseWidget({
    required this.item,
    required this.notifier,
    super.key,
  });

  final DrinkModel item;
  final DrinksNotifier notifier;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            notifier.removeDrinks(item: item, isFromCartDetail: true);
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
            notifier.addDrinks(item: item);
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
              Icons.add,
              color: whiteColor,
              size: 20.spMin,
            ),
          ),
        ),
      ],
    );
  }
}
