import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:pif_flutter/generated/l10n.dart';
import 'package:pif_flutter/utils/colors.dart';
import 'package:pif_flutter/utils/styles.dart';
import 'package:pif_flutter/widgets/wheel_chooser.dart';

class TimePickerWidget extends StatefulWidget {
  const TimePickerWidget({
    required this.onCancel,
    required this.onConfirm,
    required this.startTime,
    required this.endTime,
    super.key,
  });

  final DateTime startTime;
  final DateTime endTime;
  final VoidCallback onCancel;
  final void Function(DateTime?, DateTime?) onConfirm;

  @override
  State<TimePickerWidget> createState() => _TimePickerWidgetState();
}

class _TimePickerWidgetState extends State<TimePickerWidget> {
  List<WheelChoice<DateTime>>? lstData = <WheelChoice<DateTime>>[];
  DateTime? startDateTime;
  DateTime? endDateTime;
  int? startTimeIndex = 0;
  int? endTimeIndex = 0;

  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() {
    var date = DateTime(2000);
    date = DateTime(date.year, date.month, date.day);
    for (var i = 0; i < 96; i++) {
      lstData?.add(
        WheelChoice(
          value: date.add(Duration(minutes: i * 15)),
          title: DateFormat('hh:mm a').format(date.add(Duration(minutes: i * 15))),
        ),
      );
    }
    initTimeData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 16.h, bottom: 16.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            blurRadius: 10,
            color: grayE3,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).selectTime,
            style: Style.commonTextStyle(
              color: textColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                WheelChooser<DateTime>.choices(
                  choices: lstData,
                  itemSize: 40.h,
                  listWidth: 120.w,
                  listHeight: 200.h,
                  isInfinite: true,
                  startPosition: startTimeIndex,
                  selectTextStyle: TextStyle(color: primaryColor, fontSize: 15.sp),
                  unSelectTextStyle: TextStyle(color: grayD1, fontSize: 13.sp),
                  onChoiceChanged: (value) {
                    startDateTime = value as DateTime;
                  },
                ),
                SizedBox(
                  width: 20.w,
                ),
                Text(
                  S.of(context).to,
                  style: Style.commonTextStyle(
                    color: primaryColor,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  width: 20.w,
                ),
                WheelChooser<DateTime>.choices(
                  choices: lstData,
                  itemSize: 40.h,
                  listWidth: 120.w,
                  listHeight: 200.h,
                  isInfinite: true,
                  startPosition: endTimeIndex,
                  selectTextStyle: TextStyle(color: primaryColor, fontSize: 15.sp),
                  unSelectTextStyle: TextStyle(color: grayD1, fontSize: 13.sp),
                  onChoiceChanged: (value) {
                    endDateTime = value as DateTime;
                  },
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  widget.onCancel.call();
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  foregroundColor: primaryColor,
                  backgroundColor: Colors.white,
                ),
                child: Center(
                  child: Text(
                    S.of(context).cancel,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  widget.onConfirm.call(startDateTime, endDateTime);
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: primaryColor,
                ),
                child: Center(
                  child: Text(
                    S.of(context).confirm,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  void initTimeData() {
    final startTimeData = lstData?.firstWhereOrNull(
      (element) => !element.value.isBefore(widget.startTime) && !element.value.isAfter(widget.startTime),
    );
    if (startTimeData != null) {
      startTimeIndex = lstData?.indexOf(startTimeData);
      startDateTime = startTimeData.value;
    } else {
      startDateTime = DateTime(2001, 1, 1);
    }

    final endTimeData = lstData?.firstWhereOrNull(
      (element) => !element.value.isBefore(widget.endTime) && !element.value.isAfter(widget.endTime),
    );
    if (endTimeData != null) {
      endTimeIndex = lstData?.indexOf(endTimeData);
      endDateTime = endTimeData.value;
    } else {
      endDateTime = DateTime(2001, 1, 1);
    }
  }
}
