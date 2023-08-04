import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pif_flutter/utils/colors.dart';
import 'package:pif_flutter/utils/styles.dart';

class InformationWidget extends StatelessWidget {
  const InformationWidget({
    required this.svgString,
    required this.details,
    this.isBuildingIcon = false,
    this.isSpaceName = false,
    super.key,
  });

  final String svgString;
  final String details;
  final bool? isBuildingIcon;
  final bool? isSpaceName;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: isBuildingIcon! ? 2.w : 0.w),
          child: SvgPicture.asset(
            svgString,
            height: isBuildingIcon! ? 12.h : 16.h,
            width: isBuildingIcon! ? 12.w : 16.w,
            color: isBuildingIcon! ? null : gray89,
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            details,
            style: Style.commonTextStyle(
              color: grayTextColor,
              fontSize: isSpaceName! ? 14.sp : 12.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
