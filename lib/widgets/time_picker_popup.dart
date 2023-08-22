import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:pif_flutter/generated/l10n.dart';
import 'package:pif_flutter/utils/colors.dart';
import 'package:pif_flutter/utils/styles.dart';
import 'package:pif_flutter/widgets/wheel_chooser.dart';

class TimePickerPopup extends StatefulWidget {
  const TimePickerPopup({
    required this.onCancel,
    required this.onConfirm,
    required this.timeData,
    this.timeGap = TimeGap.fiftyMin,
    super.key,
  });

  final DateTime timeData;
  final VoidCallback onCancel;
  final void Function(DateTime?) onConfirm;
  final TimeGap timeGap;

  @override
  State<TimePickerPopup> createState() => _TimePickerPopupState();
}

class _TimePickerPopupState extends State<TimePickerPopup> {
  List<WheelChoice<DateTime>>? lstData = <WheelChoice<DateTime>>[];
  DateTime? selectedDateTime;
  int? selectedTimeIndex = 0;

  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() {
    var date = DateTime.now();
    date = DateTime(date.year, date.month, date.day);

    if (widget.timeGap == TimeGap.fiftyMin) {
      for (var i = 0; i < 96; i++) {
        lstData?.add(
          WheelChoice(
            value: date.add(Duration(minutes: i * 15)),
            title: DateFormat('hh:mm a')
                .format(date.add(Duration(minutes: i * 15))),
          ),
        );
      }
    } else {
      for (var i = 0; i < 24; i++) {
        lstData?.add(
          WheelChoice(
            value: date.add(Duration(minutes: i * 60)),
            title: DateFormat('hh:mm a')
                .format(date.add(Duration(minutes: i * 60))),
          ),
        );
      }
    }

    initTimeData();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      /// pass empty because to prevent the time picker hiding,
      /// when click inside the container
      onTap: () {},
      child: Container(
        padding:
            EdgeInsets.only(left: 24.w, right: 24.w, top: 16.h, bottom: 16.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: whiteColor,
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
              child: WheelChooser<DateTime>.choices(
                choices: lstData,
                itemSize: 40.h,
                listWidth: 120.w,
                listHeight: 200.h,
                isInfinite: true,
                startPosition: selectedTimeIndex,
                selectTextStyle:
                    TextStyle(color: primaryColor, fontSize: 15.sp),
                unSelectTextStyle: TextStyle(color: grayD1, fontSize: 13.sp),
                onChoiceChanged: (value) {
                  selectedDateTime = value as DateTime;
                },
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
                    backgroundColor: whiteColor,
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
                    widget.onConfirm.call(selectedDateTime);
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: whiteColor,
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
      ),
    );
  }

  void initTimeData() {
    final data = lstData?.firstWhereOrNull(
      (element) =>
          !element.value.isBefore(widget.timeData) &&
          !element.value.isAfter(widget.timeData),
    );
    if (data != null) {
      selectedTimeIndex = lstData?.indexOf(data);
      selectedDateTime = data.value;
    } else {
      /// now it will get the date from the timeData
      final initialDate = DateTime(
        widget.timeData.year,
        widget.timeData.month,
        widget.timeData.day,
      );
      selectedDateTime = initialDate;
    }
  }
}

enum TimeGap { fiftyMin, oneHour }
