import 'package:flutter/material.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/ui/space_booking/index.dart';

class CapacityView extends StatelessWidget {
  const CapacityView({
    required this.provider,
    required this.notifier,
    super.key,
  });

  final FilterByState provider;
  final FilterByNotifier notifier;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          Text(
            S.of(context).capacity,
            style: Style.commonTextStyle(
              color: textColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          const Spacer(),
          InkWell(
            onTap: notifier.removeCapacity,
            child: Container(
              height: 36.h,
              width: 36.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: provider.capacity == 0 ? grayBgColor : primaryColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.remove_rounded,
                size: 16.sp,
                color: whiteColor,
              ),
            ),
          ),
          SizedBox(
            width: 21.w,
          ),
          Container(
            width: 37.w,
            height: 34.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                color: expireBgColor,
                width: 1.w,
              ),
            ),
            child: Text(
              provider.capacity == 0 ? '-' : provider.capacity.toString(),
              style: Style.commonTextStyle(
                color: textColor,
                fontSize: 18.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(
            width: 21.w,
          ),
          InkWell(
            onTap: notifier.addCapacity,
            child: Container(
              height: 36.h,
              width: 36.w,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: primaryColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.add,
                size: 16.sp,
                color: whiteColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
