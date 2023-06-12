import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pif_flutter/generated/l10n.dart';
import 'package:pif_flutter/ui/booking_details/widget/guests_list.dart';
import 'package:pif_flutter/ui/booking_details/widget/list_tile_widget.dart';
import 'package:pif_flutter/ui/booking_details/widget/room_information.dart';
import 'package:pif_flutter/ui/booking_details/widget/room_slider.dart';
import 'package:pif_flutter/ui/booking_list/extensions/booking_status_extensions.dart';
import 'package:pif_flutter/ui/booking_list/model/booking_list_model.dart';
import 'package:pif_flutter/utils/colors.dart';
import 'package:pif_flutter/utils/styles.dart';

class RoomDetails extends StatelessWidget {
  const RoomDetails({required this.item, super.key});

  final BookingListModel item;

  @override
  Widget build(BuildContext context) {
    final borderRadius = 24.r;
    final boldStyle = Style.commonTextStyle(
      color: blackColor,
      fontSize: 18.sp,
      fontWeight: FontWeight.w500,
    );
    final pageController = PageController();
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 24.h,
          horizontal: 16.w,
        ),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(borderRadius),
            topLeft: Radius.circular(borderRadius),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 4.h,
                horizontal: 16.w,
              ),
              decoration: BoxDecoration(
                color: item.status!.getStatusBgColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(15.r),
                ),
              ),
              child: Text(
                item.status!.getStatusText ?? '',
                style: Style.commonTextStyle(
                  color: item.status!.getStatusTextColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(height: 20.h),
            RoomInformation(data: item),
            SizedBox(height: 24.h),
            Text(
              S.of(context).host,
              style: boldStyle,
            ),
            SizedBox(height: 10.h),
            const ListTileWidget(
              imageProfile: 'https://picsum.photos/80/80',
              userName: 'Khaled moh (you)',
              userPosition: 'Product owner',
            ),
            SizedBox(height: 24.h),
            Text(
              S.of(context).guests,
              style: boldStyle,
            ),
            SizedBox(height: 10.h),
            const GuestsList(),
            Text(
              S.of(context).roomDetails,
              style: boldStyle,
            ),
            SizedBox(height: 5.h),
            RoomSlider(
              pageController: pageController,
            ),
          ],
        ),
      ),
    );
  }
}
