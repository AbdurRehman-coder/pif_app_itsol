import 'package:flutter/material.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/widget/shimmer_wrapper.dart';

class PreviousVisitorHistoryShimmer extends StatelessWidget {
  const PreviousVisitorHistoryShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (_, index) {
        return ShimmerEffect(
          width: double.infinity,
          height: 30.h,
        );
      },
      separatorBuilder: (_, index) {
        return SizedBox(height: 10.h);
      },
      itemCount: 3,
    );
  }
}
