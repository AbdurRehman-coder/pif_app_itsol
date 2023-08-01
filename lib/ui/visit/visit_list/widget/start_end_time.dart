import 'package:dixels_sdk/features/commerce/visit/models/visit_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pif_flutter/common/extensions/date_time_extension.dart';
import 'package:pif_flutter/utils/colors.dart';
import 'package:pif_flutter/utils/styles.dart';

class StartEndTime extends StatelessWidget {
  const StartEndTime({
    super.key,
    required this.visitModel,
  });

  final VisitModel? visitModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: grayEB),
            ),
            padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 5.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Start', // hard coded text, need to be added in utils
                  style: Style.commonTextStyle(
                    color: gray85,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Text(
                  visitModel?.visitStartDate == null
                      ? ''
                      : '${visitModel?.visitStartDate?.getCommonFormatDate(
                          pattern: 'dd MMM yyyy',
                        )}, ${visitModel?.visitStartDate?.getTimeWithLowerCase()}',
                  style: Style.commonTextStyle(
                    color: blackColorWith900,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          width: 8.w,
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: grayEB),
            ),
            padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 5.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'End',
                  style: Style.commonTextStyle(
                    color: gray85,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Text(
                  visitModel?.visitEndDate == null
                      ? ''
                      : '${visitModel?.visitEndDate?.getCommonFormatDate(
                          pattern: 'dd MMM yyyy',
                        )}, ${visitModel?.visitEndDate?.getTimeWithLowerCase()}',
                  style: Style.commonTextStyle(
                    color: blackColorWith900,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
