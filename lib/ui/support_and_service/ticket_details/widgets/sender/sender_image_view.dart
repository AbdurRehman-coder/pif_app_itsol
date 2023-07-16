import 'package:dixels_sdk/features/commerce/tickets/model/ticket_comment_model.dart';
import 'package:flutter/material.dart';
import 'package:pif_flutter/common/extensions/date_time_extension.dart';
import 'package:pif_flutter/common/extensions/image_extensions.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/widgets/custom_image.dart';

class SenderImageView extends StatelessWidget {
  const SenderImageView({required this.item, super.key});

  final TicketCommentModel item;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          width: 176.w,
          height: 160.h,
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          decoration: BoxDecoration(
            color: primaryColor,
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
        Text(
          item.dateCreated!.toFormattedString('hh:mm a'),
          style: Style.commonTextStyle(
            color: dayTextColor,
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
