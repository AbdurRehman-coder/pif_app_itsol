import 'package:flutter/material.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/widgets/custom_image.dart';

class PersonJoinView extends StatelessWidget {
  const PersonJoinView({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(
            color: grayBorderColor,
            thickness: 1.5,
          ),
        ),
        SizedBox(
          width: 16.w,
        ),
        CustomImage(
          height: 24.h,
          width: 24.w,
          shape: BoxShape.circle,
          image: const NetworkImage('https://randomuser.me/api/portraits/men/22.jpg'),
        ),
        SizedBox(
          width: 9.w,
        ),
        Text(
          'Tamer A. Joined the thread',
          style: Style.commonTextStyle(
            color: textColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(
          width: 16.w,
        ),
        const Expanded(
          child: Divider(
            color: grayBorderColor,
            thickness: 1.5,
          ),
        ),
      ],
    );
  }
}
