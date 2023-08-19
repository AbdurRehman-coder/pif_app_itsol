import 'package:flutter/cupertino.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/widget/shimmer_wrapper.dart';

class CardsShimmers extends StatelessWidget {
  const CardsShimmers({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: ShimmerEffect(
        width: double.infinity,
        height: 120.h,
        borderRadius: BorderRadius.all(
          Radius.circular(20.r),
        ),
      ),
    );
  }
}
