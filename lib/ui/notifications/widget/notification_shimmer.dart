import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pif_flutter/common/shared/widget/shimmer_wrapper.dart';

class NotificationShimmerWidget extends StatelessWidget {
  const NotificationShimmerWidget({Key? key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: ShimmerEffect(
            width: double.infinity.w,
            height: 100.h,
            borderRadius: BorderRadius.circular(18.r),
          ),
        );
      },
    );
  }
}
