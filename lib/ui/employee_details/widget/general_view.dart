import 'package:dixels_sdk/dixels_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pif_flutter/common/extensions/string_extensions.dart';
import 'package:pif_flutter/common/index.dart';

class GeneralView extends StatelessWidget {
  const GeneralView({required this.data, super.key});

  final UserModel data;

  @override
  Widget build(BuildContext context) {
    final mobileNumber =
        data.customFields!.firstWhere((element) => element.name == 'MobileNo').customValue.data.toString();

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
              mobileNumber.toFormatPhoneNumber(),
              style: Style.commonTextStyle(
                color: grayTextColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ).visibility(visible: mobileNumber.isNotEmpty),
        SizedBox(
          height: 12.h,
        ).visibility(visible: mobileNumber.isNotEmpty),
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
              data.emailAddress ?? '',
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
