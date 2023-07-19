import 'package:dixels_sdk/features/commerce/tickets/model/ticket_comment_model.dart';
import 'package:flutter/material.dart';
import 'package:pif_flutter/common/extensions/date_time_extension.dart';
import 'package:pif_flutter/common/index.dart';

class SendTextView extends StatelessWidget {
  const SendTextView({required this.item, super.key});

  final TicketCommentModel item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 50.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: primaryLightColor,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Text(
              item.commentDescription ?? '',
              style: Style.commonTextStyle(
                color: whiteColor,
                fontSize: 15.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(
            height: 6.h,
          ),
          Text(
            item.dateCreated!.toLocal().toFormattedString('hh:mm a'),
            style: Style.commonTextStyle(
              color: dayTextColor,
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
