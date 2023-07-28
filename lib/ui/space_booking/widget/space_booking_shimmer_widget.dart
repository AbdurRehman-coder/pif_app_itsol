import 'package:flutter/material.dart';
import 'package:pif_flutter/common/extensions/context_extensions.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/widget/shimmer_wrapper.dart';

class SpaceBookingShimmerWidget extends StatelessWidget {
  const SpaceBookingShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 4,
      itemBuilder: (context, index) {
        return ShimmerEffect(
          width: context.screenWidth,
          height: 168.h,
          borderRadius: BorderRadius.circular(40.r),
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(
          height: 15.h,
        );
      },
    );
  }
}
