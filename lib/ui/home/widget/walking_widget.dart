import 'package:dixels_sdk/features/commerce/visit/models/visit_model.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pif_flutter/common/index.dart';

class WalkingWidget extends StatelessWidget {
  const WalkingWidget({required this.visit, super.key});

  final VisitModel visit;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          Assets.walkingTo,
          width: 16.w,
          height: 16.h,
        ),
        Text(
          visit.visitStartDate!.getTime(),
          style: Style.commonTextStyle(
            color: dayTextColor,
            fontSize: 10.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(width: 4.w),
        const Expanded(child: DottedLine()),
        Text(
          visit.visitStartDate!
              .daysBetweenWithSpecificDate(secondDate: visit.visitEndDate!),
          style: Style.commonTextStyle(
            color: dayTextColor,
            fontSize: 10.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Expanded(child: DottedLine()),
        SizedBox(width: 4.w),
        SvgPicture.asset(
          Assets.walkingFrom,
          width: 16.w,
          height: 16.h,
        ),
        Text(
          visit.visitEndDate!.getTime(),
          style: Style.commonTextStyle(
            color: dayTextColor,
            fontSize: 10.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
