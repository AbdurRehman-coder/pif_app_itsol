import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pif_flutter/common/index.dart';

class GeneralView extends StatelessWidget {
  const GeneralView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SvgPicture.asset(
              Assets.svgCall,
            ),
            SizedBox(
              width: 8.w,
            ),
            Text(
              '+966 4526 345 678',
              style: Style.commonTextStyle(
                color: grayTextColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
        SizedBox(
          height: 12.h,
        ),
        Row(
          children: [
            SvgPicture.asset(
              Assets.email,
              colorFilter: const ColorFilter.mode(grayTextColor, BlendMode.srcIn),
            ),
            SizedBox(
              width: 8.w,
            ),
            Text(
              'ahmad@pif.gov.sa',
              style: Style.commonTextStyle(
                color: grayTextColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        )
      ],
    );
  }
}
