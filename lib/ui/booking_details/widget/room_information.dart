import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pif_flutter/helpers/assets.dart';
import 'package:pif_flutter/ui/booking_details/widget/information_widget.dart';
import 'package:pif_flutter/ui/booking_list/index.dart';

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
          svgString: Assets.hotelBuildingIcon,
          details: data.spaceName ?? '',
          isBuildingIcon: true,
          isSpaceName: true,
        ),
        SizedBox(height: 8.h),
        InformationWidget(
          svgString: Assets.calenderTodaySvg,
          details: data.timeString ?? '',
        ),
        SizedBox(height: 8.h),
        InformationWidget(
          svgString: Assets.clock,
          details: data.timeRemaining ?? '',
        ),
        SizedBox(height: 8.h),
        InformationWidget(
          svgString: Assets.repeatDateIcon,
          details: data.repeatedDates ?? '',
          isBuildingIcon: true,
        ),
      ],
    );
  }
}
