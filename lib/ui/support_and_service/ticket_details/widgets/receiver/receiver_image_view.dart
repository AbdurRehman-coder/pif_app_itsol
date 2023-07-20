import 'package:dixels_sdk/features/commerce/tickets/model/ticket_comment_model.dart';
import 'package:flutter/material.dart';
import 'package:pif_flutter/common/extensions/date_time_extension.dart';
import 'package:pif_flutter/common/extensions/image_extensions.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/widgets/custom_image.dart';

class ReceiverImageView extends StatelessWidget {
  const ReceiverImageView({required this.item, super.key});

  final TicketCommentModel item;

  @override
  Widget build(BuildContext context) {
    print(
        'item.commentAttachment!.link!.href!.getImageUrl ${item.commentAttachment!.link!.href!.getImageUrl.replaceAll('download=true', 'download=false')}',);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // Image.network(
        //   item.commentAttachment!.link!.href!.getImageUrl,
        // ),
        Padding(
          padding: EdgeInsets.only(bottom: 10.h),
          child: CustomImage(
            height: 24.h,
            width: 24.w,
            image:  NetworkImage(
              item.commentAttachment!.getImageUrl,
            ),
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(
          width: 8.w,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 176.w,
              height: 160.h,
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: expireBgColor,
                border: Border.all(color: grayBorderColor),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: CustomImage(
                fit: BoxFit.cover,
                borderRadius: BorderRadius.circular(16.r),
                image: NetworkImage(item.commentAttachment!.getImageUrl),
              ),
            ),
            SizedBox(
              height: 6.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Text(
                item.dateCreated!.toLocal().toFormattedString('hh:mm a'),
                style: Style.commonTextStyle(
                  color: dayTextColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
