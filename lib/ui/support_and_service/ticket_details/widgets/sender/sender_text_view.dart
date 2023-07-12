import 'package:flutter/material.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/ui/support_and_service/ticket_details/model/comment_model.dart';

class SendTextView extends StatelessWidget {
  const SendTextView({required this.item, super.key});

  final CommentModel item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 50.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: primaryLightColor,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Text(
              'I am assigning this to an expert to help you more',
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
            '12:30 PM',
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
