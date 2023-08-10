import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pif_flutter/common/shared/widget/shimmer_wrapper.dart';

class BookingListShimmerWidget extends StatelessWidget {
  const BookingListShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 43.h,
      child: ListView.separated(
        itemCount: 4,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemBuilder: (context, index) {
          return ShimmerEffect(
            width: 80.w,
            height: 39.h,
            borderRadius: BorderRadius.circular(40.r),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            width: 10.w,
          );
        },
      ),
    );
  }
}
