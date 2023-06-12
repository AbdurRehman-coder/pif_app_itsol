import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pif_flutter/helpers/assets.dart';
import 'package:pif_flutter/ui/booking_list/index.dart';
import 'package:pif_flutter/utils/colors.dart';
import 'package:pif_flutter/utils/styles.dart';

class RoomInformation extends StatelessWidget {
  const RoomInformation({
    required this.data,
    super.key,
  });

  final BookingListModel data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InformationWidget(
          svgString: Assets.hourIcon,
          details: data.timeRemaining ?? '',
        ),
        SizedBox(height: 12.h),
        InformationWidget(
          svgString: Assets.calendar,
          details: data.timeString ?? '',
        ),
        SizedBox(height: 12.h),
        InformationWidget(
          svgString: Assets.repeatIcon,
          details: data.repeatedDates ?? '',
        ),
      ],
    );
  }
}

class InformationWidget extends StatelessWidget {
  const InformationWidget({
    required this.svgString,
    required this.details,
    super.key,
  });

  final String svgString;
  final String details;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          svgString,
          height: 20.h,
          width: 20.w,
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            details,
            style: Style.commonTextStyle(
              color: grayTextColor,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
