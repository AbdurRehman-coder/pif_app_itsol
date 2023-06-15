import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pif_flutter/common/index.dart';

class VisitInformation extends StatelessWidget {
  const VisitInformation({
    required this.svgImage,
    required this.text,
    super.key,
  });

  final String svgImage;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          svgImage,
        ),
        SizedBox(
          width: 9.w,
        ),
        Text(
          text,
          style: Style.commonTextStyle(
            color: grayTextColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
