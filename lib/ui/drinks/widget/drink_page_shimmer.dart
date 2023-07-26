import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pif_flutter/common/shared/widget/shimmer_wrapper.dart';

class DrinkPageShimmerWidget extends StatelessWidget {
  const DrinkPageShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10.w,
        mainAxisSpacing: 16.h,
        childAspectRatio: 1,
      ),
      itemCount: 4,
      itemBuilder: (context, index) {
        return ShimmerEffect(
          width: 50.w,
          height: 50.h,
          borderRadius: BorderRadius.circular(40.r),
        );
      },
    );
  }
}
