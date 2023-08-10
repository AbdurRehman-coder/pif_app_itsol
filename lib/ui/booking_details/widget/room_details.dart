import 'package:dixels_sdk/features/commerce/booking/model/booking_model.dart';
import 'package:flutter/material.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/ui/booking_details/widget/guests_list.dart';
import 'package:pif_flutter/ui/booking_details/widget/list_tile_widget.dart';
import 'package:pif_flutter/ui/booking_details/widget/room_information.dart';
import 'package:pif_flutter/ui/booking_list/extensions/booking_status_extensions.dart';

class RoomDetails extends StatelessWidget {
  const RoomDetails({required this.item, super.key});

  final BookingModel item;

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
              Flexible(
                child: Text(
                  item.roomModel != null && item.roomModel!.name != null ? item.roomModel?.name ?? '' : '-',
                  maxLines: 2,
                  style: Style.commonTextStyle(
                    color: textColor,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 6.h,
                  horizontal: 12.w,
                ),
                decoration: BoxDecoration(
                  color: item.bookingStatus?.key!.getStatusBgColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(16.r),
                  ),
                ),
                child: Text(
                  item.bookingStatus?.name ?? '',
                  style: Style.commonTextStyle(
                    color: item.bookingStatus?.key!.getStatusTextColor,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ).visibility(visible: item.bookingStatus != null && item.bookingStatus!.name != null),
            ],
          ),
          SizedBox(
            height: 8.h,
          ),
          Text(
            item.subject ?? '',
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
          ListTileWidget(
            imageProfile: 'https://picsum.photos/80/80',
            userName: item.creator?.name ?? '',
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
          ).visibility(visible: item.attendees!.isNotEmpty),
          SizedBox(height: 10.h).visibility(visible: item.attendees!.isNotEmpty),
          GuestsList(model: item.attendees!).visibility(visible: item.attendees!.isNotEmpty),
        ],
      ),
    );
  }
}
