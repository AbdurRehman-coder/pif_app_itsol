import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/widget/second_custom_text_field.dart';
import 'package:pif_flutter/ui/visit/invite_visitor/index.dart';

class EndDateAndTime extends StatelessWidget {
  const EndDateAndTime({
    required this.notifier,
    required this.provider,
    super.key,
  });

  final InviteVisitorNotifier notifier;
  final InviteVisitorState provider;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.current.end,
          style: Style.commonTextStyle(
            color: blackColorWith900,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        InkWell(
          splashColor: whiteColor,
          onTap: () => notifier.checkIfAnyDateOrTimeIsOpen()
              ? notifier.closeDateAndTime()
              : null,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: InkWell(
                  onTap: notifier.openEndDatePickerDialog,
                  child: SecondCustomTextField(
                    textEditingController: notifier.endDateController,
                    isFocus: provider.isOpenEndDatePicker,
                    enabled: false,
                    checkEmpty: true,
                    style: Style.commonTextStyle(
                      color: blackColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    hintText: S.current.endingDate,
                    suffixIcon: const Icon(
                      Icons.calendar_today,
                      color: expireStatusColor,
                      size: 20,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: InkWell(
                  onTap: notifier.openEndTimePickerDialog,
                  child: SecondCustomTextField(
                    fillColor: whiteColor,
                    textEditingController: notifier.endTimeController,
                    isFocus: provider.isOpenEndTimePicker,
                    enabled: false,
                    checkEmpty: true,
                    hintText: S.current.time,
                    style: Style.commonTextStyle(
                      color: blackColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    suffixIcon: const Icon(
                      Icons.keyboard_arrow_down_sharp,
                      color: expireStatusColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
