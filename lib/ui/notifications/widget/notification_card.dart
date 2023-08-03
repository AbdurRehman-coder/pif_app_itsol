import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pif_flutter/common/extensions/date_time_extension.dart';
import 'package:pif_flutter/helpers/assets.dart';
import 'package:pif_flutter/ui/notifications/model/notification_model.dart';
import 'package:pif_flutter/utils/colors.dart';
import 'package:pif_flutter/utils/styles.dart';

class NotificationCard extends StatelessWidget {
  final NotificationModel notification;
  final int? index;
  const NotificationCard({required this.notification, this.index, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          Assets.person,
          height: 40.h,
          width: 40.w,
          fit: BoxFit.scaleDown,
        ),
        SizedBox(
          width: 8.w,
        ),
        Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: size.width * 0.7,
                  child: Text(
                    notification.title,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: Style.commonTextStyle(
                      color: textColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(
                  height: 4.h,
                ),
                Text(
                  notification.time.getTimePassed(),
                  style: Style.commonTextStyle(
                    color: darkBorderColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 16.w,
            ),
            if (index == 0)
              const CircleAvatar(
                radius: 4,
                backgroundColor: primaryDarkColor,
              )
            else
              const SizedBox(),
          ],
        ),
      ],
    );
  }
}
