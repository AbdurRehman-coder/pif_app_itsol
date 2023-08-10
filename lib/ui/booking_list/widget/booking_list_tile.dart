import 'package:dixels_sdk/features/commerce/booking/model/booking_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/extensions/context_extensions.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/message/delete_meesage.dart';
import 'package:pif_flutter/routes/routes.dart';
import 'package:pif_flutter/ui/booking_list/extensions/booking_status_extensions.dart';
import 'package:pif_flutter/ui/booking_list/index.dart';

class BookingListTile extends ConsumerWidget {
  const BookingListTile({required this.data, super.key});

  final BookingModel data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(bookingListProvider.notifier);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(6.r),
        boxShadow: [
          BoxShadow(
            color: darkTextColor.withOpacity(0.10),
            offset: const Offset(0, 2),
            blurRadius: 4.r,
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          AppRouter.pushNamed(Routes.bookingDetailsScreen, args: data);
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 38.h,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: data.bookingStatus?.key!.getStatusBgColor,
                    borderRadius: BorderRadius.circular(
                      20.r,
                    ),
                  ),
                  child: Text(
                    data.bookingStatus?.name ?? '',
                    style: Style.commonTextStyle(
                      color: data.bookingStatus?.key!.getStatusTextColor,
                      fontSize: 14.sp,
                      height: 1.4,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ).visibility(visible: data.bookingStatus != null && data.bookingStatus!.name != null),
                SizedBox(
                  height: 8.h,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 115,
                  child: Text(
                    data.subject ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Style.commonTextStyle(
                      color: textColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      height: 14.h,
                      width: 14.w,
                      Assets.placeIcon,
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    SizedBox(
                      width: context.screenWidth - 134,
                      child: Text(
                        data.roomModel != null &&
                                data.roomModel!.name != null &&
                                data.roomModel!.name!.isNotEmpty
                            ? data.roomModel?.name ?? ''
                            : '-',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Style.commonTextStyle(
                          color: grayTextColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12.h,
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      height: 16.h,
                      width: 16.w,
                      colorFilter: ColorFilter.mode(blackColorWith900.withOpacity(0.45), BlendMode.srcIn),
                      Assets.calenderTodaySvg,
                      fit: BoxFit.scaleDown,
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Text(
                      notifier.formatTimeString(data: data),
                      style: Style.commonTextStyle(
                        color: grayTextColor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12.h,
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      height: 16.h,
                      width: 16.w,
                      Assets.clock,
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Text(
                      notifier.formatLeftTime(data: data),
                      style: Style.commonTextStyle(
                        color: grayTextColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12.h,
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      height: 14.h,
                      width: 14.w,
                      Assets.repeatAgain,
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    SizedBox(
                      width: context.screenWidth - 134,
                      child: Text(
                        notifier.formatDateString(data: data),
                        style: Style.commonTextStyle(
                          color: grayTextColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(),
            PopupMenuButton(
              onSelected: (value) {
                if (value == 1) {
                  AppRouter.pushNamed(Routes.bookingScreen, args: [data.roomModel, false, data]);
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 1,
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        Assets.editIcon,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(
                        S.of(context).edit,
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
                  value: 3,
                  onTap: () {
                    Future.delayed(
                      const Duration(milliseconds: 200),
                      () {
                        deleteMessagePopup(
                          context: context,
                          deleteMessage: S.of(context).deleteMessageBooking,
                          onClickYes: () async {
                            await AppRouter.pop();
                            await notifier.onClickDeleteBooking(booking: data, context: context);
                          },
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
              icon: Icon(
                Icons.more_vert_outlined,
                color: blackColor.withOpacity(0.45),
              ),
            ).visibility(visible: notifier.isEditBooking(data: data)),
          ],
        ),
      ),
    );
  }
}
