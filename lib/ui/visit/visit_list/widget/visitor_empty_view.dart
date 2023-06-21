import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pif_flutter/common/index.dart';

class VisitorEmptyView extends StatelessWidget {
  const VisitorEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 60.h, left: 20.w, right: 20.w),
      child: Column(
        children: [
          SvgPicture.asset(
            Assets.visitorEmpty,
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            S.of(context).noVisitors,
            textAlign: TextAlign.center,
            style: Style.commonTextStyle(
              color: primaryColor,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(
            height: 3.h,
          ),
          Text(
            S.of(context).visitorEmptyMsg,
            textAlign: TextAlign.center,
            style: Style.commonTextStyle(
              color: textColor,
              fontSize: 24.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
