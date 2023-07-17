import 'package:flutter/material.dart';
import 'package:pif_flutter/common/index.dart';

class TileCard extends StatelessWidget {
  const TileCard({
    required this.title,
    required this.description,
    super.key,
  });

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Style.commonTextStyle(
            color: blackColor,
            fontSize: 30.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 10.h),
        Text(
          description,
          style: Style.commonTextStyle(
            color: hintColor,
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
          ),
          maxLines: 3,
        ),
      ],
    );
  }
}
