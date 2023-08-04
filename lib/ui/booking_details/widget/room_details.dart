import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pif_flutter/generated/l10n.dart';
import 'package:pif_flutter/ui/booking_details/widget/guests_list.dart';
import 'package:pif_flutter/ui/booking_details/widget/list_tile_widget.dart';
import 'package:pif_flutter/ui/booking_details/widget/room_information.dart';
import 'package:pif_flutter/ui/booking_list/extensions/booking_status_extensions.dart';
import 'package:pif_flutter/ui/booking_list/model/booking_list_model.dart';
import 'package:pif_flutter/utils/colors.dart';
import 'package:pif_flutter/utils/styles.dart';

class RoomDetails extends StatelessWidget {
  const RoomDetails({required this.item, super.key});

  final BookingListModel item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                item.spaceName.toString(),
                style: Style.commonTextStyle(
                  color: textColor,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 6.h,
                  horizontal: 12.w,
                ),
                decoration: BoxDecoration(
                  color: item.status!.getStatusBgColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(16.r),
                  ),
                ),
                child: Text(
                  item.status!.getStatusText ?? '',
                  style: Style.commonTextStyle(
                    color: item.status!.getStatusTextColor,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8.h,
          ),
          Text(
            item.bookingTitle ?? '',
            style: Style.commonTextStyle(
              color: textColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 16.h),
          /// Room information
          RoomInformation(data: item),
          SizedBox(height: 16.h),
          Text(
            S.of(context).host,
            style: Style.commonTextStyle(
              color: textColor,
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 4.h),
          const ListTileWidget(
            imageProfile: 'https://picsum.photos/80/80',
            userName: 'Khaled moh(you)',
            userPosition: 'Product owner',
          ),
          SizedBox(height: 18.h),
          Text(
            S.of(context).guests,
            style: Style.commonTextStyle(
              color: textColor,
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 10.h),
          const GuestsList(),
        ],
      ),
    );
  }
}
