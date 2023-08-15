import 'package:cached_network_image/cached_network_image.dart';
import 'package:dixels_sdk/features/users/notification/model/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pif_flutter/common/extensions/date_time_extension.dart';
import 'package:pif_flutter/common/utilities/constant.dart';
import 'package:pif_flutter/helpers/assets.dart';
import 'package:pif_flutter/utils/colors.dart';
import 'package:pif_flutter/utils/styles.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    required this.notification,
    super.key,
  });

  final NotificationModel notification;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 40.h,
          width: 40.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: grayBorderColor),
          ),
          child: CachedNetworkImage(
            imageUrl: '${Constant.imageBaseUrl}${notification.image}',
            fit: BoxFit.scaleDown,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notification.message ?? '',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: Style.commonTextStyle(
                        color: textColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      notification.dateCreated!.getTimePassed,
                      style: Style.commonTextStyle(
                        color: darkBorderColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16.w),
              if (!notification.read!) ...[
                const CircleAvatar(
                  radius: 4,
                  backgroundColor: primaryDarkColor,
                )
              ],
            ],
          ),
        ),
      ],
    );
  }
}
