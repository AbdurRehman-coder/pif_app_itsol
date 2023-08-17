import 'package:flutter/material.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/widget/shimmer_wrapper.dart';

class CompanyListShimmer extends StatelessWidget {
  const CompanyListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80.h,
      child: ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          return  ShimmerEffect(
            height: 80.h,
            width: 80.w,
            shape: BoxShape.circle,
          );
        },
        separatorBuilder: (_, index) {
          return SizedBox(
            width: 24.w,
          );
        },
        itemCount: 6,
      ),
    );
  }
}
