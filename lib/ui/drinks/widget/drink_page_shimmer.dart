import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pif_flutter/common/shared/widget/shimmer_wrapper.dart';

class DrinkPageShimmerWidget extends StatelessWidget {
  const DrinkPageShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Expanded(
            flex: 4,
            child: Column(
              children: [
                ShimmerEffect(
                  width: double.infinity.w,
                  height: 50.h,
                  borderRadius: BorderRadius.circular(18.r),
                ),
                SizedBox(
                  height: 20.h,
                ),
                ShimmerEffect(
                  width: double.infinity.w,
                  height: 100.h,
                  borderRadius: BorderRadius.circular(18.r),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: 3,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ShimmerEffect(
                          width: 100.w,
                          height: 6.h,
                          borderRadius: BorderRadius.circular(40.r),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 20.h,
                )
              ],
            ),
          ),
          Expanded(
            flex: 6,
            child: GridView.builder(
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
                  width: 40.w,
                  height: 40.h,
                  borderRadius: BorderRadius.circular(40.r),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
