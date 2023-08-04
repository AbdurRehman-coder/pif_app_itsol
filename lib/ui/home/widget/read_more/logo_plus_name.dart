import 'package:flutter/cupertino.dart';
import 'package:pif_flutter/common/extensions/date_time_extension.dart';
import 'package:pif_flutter/common/index.dart';

class LogoNameWidget extends StatelessWidget {
  const LogoNameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final time = DateTime.now().subtract(const Duration(hours: 2));

    return Row(
      children: [
        Container(
          height: 48.h,
          width: 48.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: grayBorderColor,
              width: 1.w,
            ),
          ),
          alignment: Alignment.center,
          child: Image.asset(
            Assets.groupLogo,
            height: 35.h,
            width: 35.w,
          ),
        ),
        SizedBox(
          width: 8.w,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).co_builder,
              style: Style.commonTextStyle(
                color: textColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              time.getTimePassed(),
              style: Style.commonTextStyle(
                color: darkBorderColor,
                fontSize: 10.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
