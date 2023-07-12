import 'package:flutter/material.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/ui/support_and_service/ticket_details/model/comment_model.dart';
import 'package:pif_flutter/widgets/custom_image.dart';

class ReceiverTextView extends StatelessWidget {
  const ReceiverTextView({required this.item, super.key});

  final CommentModel item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 50.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: CustomImage(
              height: 24.h,
              width: 24.w,
              image: const NetworkImage('https://randomuser.me/api/portraits/men/41.jpg'),
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(
            width: 8.w,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: expireBgColor,
                    border: Border.all(color: grayBorderColor),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Text(
                    'I am assigning this to an expert to help you more',
                    style: Style.commonTextStyle(
                      color: textColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(
                  height: 6.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Text(
                    '12:30 PM',
                    style: Style.commonTextStyle(
                      color: dayTextColor,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
