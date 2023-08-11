import 'package:flutter/material.dart';
import 'package:pif_flutter/common/extensions/context_extensions.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/widget/shimmer_wrapper.dart';

class SearchLocationShimmerWidget extends StatelessWidget {
  const SearchLocationShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return ShimmerEffect(
          width: context.screenWidth,
          height: 62.h,
          borderRadius: BorderRadius.circular(6.r),
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(
          height: 8.h,
        );
      },
      itemCount: 10,
    );
  }
}
