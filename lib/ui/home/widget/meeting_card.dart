import 'package:avatar_stack/avatar_stack.dart';
import 'package:avatar_stack/positions.dart';
import 'package:flutter/material.dart';
import 'package:pif_flutter/common/index.dart';

class MeetingCard extends StatelessWidget {
  const MeetingCard({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = RestrictedPositions(
      align: StackAlign.right,
      maxCoverage: 0.3,
      minCoverage: 0.2,
    );
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(
        vertical: 12.h,
        horizontal: 20.w,
      ),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            Assets.meetingBackground,
          ),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Al Multaqa  301 - 4F',
            style: Style.commonTextStyle(
              color: blackColor,
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 5.h),
          Row(
            children: [
              Icon(
                Icons.timer_outlined,
                size: 25.w,
                color: expireStatusColor,
              ),
              SizedBox(width: 3.w),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '2 hrs meeting',
                      style: TextStyle(
                        color: expireStatusColor,
                        fontSize: 12.sp,
                      ),
                    )
                  ],
                  text: '3 m left -',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 12.sp,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 15.h),
          Row(
            children: [
              const Expanded(child: SizedBox()),
              Expanded(
                child: AvatarStack(
                  height: 40.h,
                  borderColor: loggedStatusColor,
                  borderWidth: 0.5,
                  settings: settings,
                  infoWidgetBuilder: (surplus) => BorderedCircleAvatar(
                    backgroundColor: primaryColor,
                    child: Text(
                      '+$surplus',
                      textAlign: TextAlign.center,
                      style: Style.commonTextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: whiteColor,
                      ),
                    ),
                  ),
                  avatars: [
                    for (var i = 0; i < 10; i++)
                      const NetworkImage(
                        'https://www.simplilearn.com/ice9/free_resources_article_thumb/what_is_image_Processing.jpg',
                      ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
