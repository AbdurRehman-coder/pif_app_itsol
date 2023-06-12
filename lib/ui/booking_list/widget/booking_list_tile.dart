import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pif_flutter/common/shared/message/delete_meesage.dart';
import 'package:pif_flutter/generated/l10n.dart';
import 'package:pif_flutter/helpers/assets.dart';
import 'package:pif_flutter/routes/app_router.dart';
import 'package:pif_flutter/routes/routes.dart';
import 'package:pif_flutter/ui/booking_list/extensions/booking_status_extensions.dart';
import 'package:pif_flutter/ui/booking_list/model/booking_list_model.dart';
import 'package:pif_flutter/utils/colors.dart';
import 'package:pif_flutter/utils/styles.dart';

class BookingListTile extends StatelessWidget {
  const BookingListTile({required this.data, super.key});

  final BookingListModel data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 15.h),
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: grayBorderColor,
          width: 1.w,
        ),
      ),
      child: InkWell(
        onTap: () {
          AppRouter.pushNamed(Routes.bookingDetailsScreen, args: data);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 29.h,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  decoration: BoxDecoration(
                    color: data.status!.getStatusBgColor,
                    borderRadius: BorderRadius.circular(
                      20.r,
                    ),
                  ),
                  child: Text(
                    data.status!.getStatusText ?? '',
                    style: Style.commonTextStyle(
                      color: data.status!.getStatusTextColor,
                      fontSize: 14.sp,
                      height: 1.4,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const Spacer(),
                PopupMenuButton(
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
                ),
              ],
            ),
            SizedBox(
              height: 8.h,
            ),
            Text(
              data.bookingTitle ?? '',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Style.commonTextStyle(
                color: textColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            Row(
              children: [
                SvgPicture.asset(
                  height: 20.h,
                  width: 20.w,
                  Assets.placeIcon,
                ),
                SizedBox(
                  width: 10.w,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(16.r),
                  child: CachedNetworkImage(
                    height: 32.r,
                    width: 32.r,
                    imageUrl: 'https://picsum.photos/50/50',
                    placeholder: (context, url) => const SizedBox(),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                ),
                SizedBox(
                  width: 8.w,
                ),
                Text(
                  data.spaceName ?? '',
                  style: Style.commonTextStyle(
                    color: dayTextColor,
                    fontSize: 16.sp,
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
                  height: 20.h,
                  width: 20.w,
                  Assets.hourIcon,
                ),
                SizedBox(
                  width: 12.w,
                ),
                Text(
                  data.timeRemaining ?? '',
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
                  height: 20.h,
                  width: 20.w,
                  Assets.calendar,
                ),
                SizedBox(
                  width: 12.w,
                ),
                Text(
                  data.timeString ?? '',
                  style: Style.commonTextStyle(
                    color: grayTextColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 14.h,
            ),
            Row(
              children: [
                SvgPicture.asset(
                  height: 20.h,
                  width: 20.w,
                  Assets.repeatIcon,
                ),
                SizedBox(
                  width: 12.w,
                ),
                Text(
                  data.repeatedDates ?? '',
                  style: Style.commonTextStyle(
                    color: grayTextColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
