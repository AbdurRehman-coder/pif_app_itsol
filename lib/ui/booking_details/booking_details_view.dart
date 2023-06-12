import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pif_flutter/common/shared/message/delete_meesage.dart';
import 'package:pif_flutter/generated/l10n.dart';
import 'package:pif_flutter/helpers/assets.dart';
import 'package:pif_flutter/routes/app_router.dart';
import 'package:pif_flutter/ui/booking_details/widget/room_details.dart';
import 'package:pif_flutter/ui/booking_list/model/booking_list_model.dart';
import 'package:pif_flutter/utils/colors.dart';
import 'package:pif_flutter/utils/styles.dart';

class BookingDetails extends StatelessWidget {
  const BookingDetails({required this.data, super.key});

  final BookingListModel data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grayF5,
      appBar: AppBar(
        backgroundColor: grayF5,
        automaticallyImplyLeading: false,
        centerTitle: false,
        titleSpacing: 0,
        elevation: 0,
        leading: IconButton(
          onPressed: AppRouter.pop,
          icon: SvgPicture.asset(
            Assets.back,
            height: 14.h,
          ),
        ),
        title: Text(
          S.of(context).bookingDetails,
          style: Style.commonTextStyle(
            color: blackColor,
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 1,
                child: Row(
                  children: [
                    SvgPicture.asset(
                      Assets.duplicateIcon,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      S.of(context).duplicate,
                      style: Style.commonTextStyle(
                        color: dayTextColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
              ),
              PopupMenuItem(
                value: 2,
                onTap: () {
                  Future.delayed(
                    const Duration(milliseconds: 200),
                    () {
                      deleteMessagePopup(
                        context: context,
                        deleteMessage: S.of(context).deleteMessageBooking,
                        onClickYes: () {},
                      );
                    },
                  );
                },
                child: Row(
                  children: [
                    SvgPicture.asset(
                      Assets.trashBit,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      S.of(context).delete,
                      style: Style.commonTextStyle(
                        color: dayTextColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
              ),
            ],
            icon: SvgPicture.asset(
              Assets.optionMenuIcon,
            ),
            offset: Offset(50.w, 50.h),
            color: whiteColor,
            elevation: 2,
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Text(
              data.bookingTitle ?? '',
              style: Style.commonTextStyle(
                color: blackColor,
                fontSize: 24.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(height: 20.h),
          Expanded(
            child: RoomDetails(
              item: data,
            ),
          ),
        ],
      ),
    );
  }
}
