import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pif_flutter/common/shared/widget/shimmer_wrapper.dart';

class TermsConditionShimmerWidget extends StatelessWidget {
  const TermsConditionShimmerWidget({Key? key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListView.builder(
            itemCount: 2,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 08.h,
                  ),
                  ShimmerEffect(
                    width: 90.w,
                    height: 50.h,
                    borderRadius: BorderRadius.circular(18.r),
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  ShimmerEffect(
                    width: double.infinity.w,
                    height: 150.h,
                    borderRadius: BorderRadius.circular(18.r),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
