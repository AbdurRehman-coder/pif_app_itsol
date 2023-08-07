import 'package:flutter/material.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/widget/shimmer_wrapper.dart';

class ServicesLoader extends StatelessWidget {
  const ServicesLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 7.h,
        mainAxisSpacing: 3.w,
      ),
      itemCount: 6,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      itemBuilder: (context, index) {
        return ShimmerEffect(
          height: 30.w,
          width: 30.w,
          borderRadius: BorderRadius.circular(18.r),
        );
      },
    );
  }
}
