import 'package:dixels_sdk/features/commerce/visit/models/visit_model.dart';
import 'package:flutter/material.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/widget/second_custom_text_field.dart';
import 'package:pif_flutter/ui/visit/invite_edit_visit/index.dart';

class EndDateAndTime extends StatelessWidget {
  const EndDateAndTime({
    required this.notifier,
    required this.provider,
    this.selectedVisit,
    super.key,
  });

  final InviteVisitorNotifier notifier;
  final InviteEditVisitState provider;
  final VisitModel? selectedVisit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.current.str_end,
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

                    isDateAndTime: true,
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

                    isDateAndTime: true,
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
