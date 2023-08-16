import 'package:flutter/material.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/widget/shimmer_wrapper.dart';

class ShimmerTicketsListView extends StatelessWidget {
  const ShimmerTicketsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding:
          EdgeInsets.only(right: 16.w, left: 16.w, bottom: 60.h, top: 10.h),
      shrinkWrap: true,
      itemBuilder: (_, index) {
        return ShimmerEffect(
          width: double.infinity,
          height: 100.h,
        );
      },
      separatorBuilder: (_, index) {
        return SizedBox(
          height: 15.h,
        );
      },
      itemCount: 7,
    );
  }
}
