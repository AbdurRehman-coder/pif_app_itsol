import 'package:dixels_sdk/features/commerce/booking/model/booking_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/helpers/assets.dart';
import 'package:pif_flutter/ui/booking_details/widget/information_widget.dart';
import 'package:pif_flutter/ui/booking_list/provider/booking_list_provider.dart';

class RoomInformation extends ConsumerWidget {
  const RoomInformation({
    required this.data,
    super.key,
  });

  final BookingModel data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(bookingListProvider.notifier);

    return Column(
      children: [
        InformationWidget(
          svgString: Assets.hotelBuildingIcon,
          details: data.roomModel != null && data.roomModel!.roomType != null
              ? data.roomModel?.roomType?.name ?? ''
              : '-',
          isBuildingIcon: true,
          isSpaceName: true,
        ),
        SizedBox(height: 8.h),
        InformationWidget(
          svgString: Assets.calenderTodaySvg,
          details: notifier.formatTimeString(data: data),
        ),
        SizedBox(height: 8.h),
        InformationWidget(
          svgString: Assets.clock,
          details: notifier.formatLeftTime(data: data),
        ),
        SizedBox(height: 8.h),
        InformationWidget(
          svgString: Assets.repeatDateIcon,
          details: notifier.formatDateString(data: data),
          isBuildingIcon: true,
        ),
      ],
    );
  }
}
