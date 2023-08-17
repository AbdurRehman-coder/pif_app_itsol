import 'package:dixels_sdk/features/commerce/visit/models/visit_model.dart';
import 'package:flutter/material.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/widget/second_custom_text_field.dart';
import 'package:pif_flutter/ui/visit/invite_edit_visit/index.dart';

class StartDateAndTime extends StatelessWidget {
  const StartDateAndTime({
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
          S.current.str_start,
          style: Style.commonTextStyle(
            color: blackColorWith900,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: InkWell(
                onTap: selectedVisit != null &&
                        selectedVisit!.visitStartDate!.isBeforeNow
                    ? null
                    : () => notifier.openStartDatePickerDialog(
                          context: context,
                        ),
                child: SecondCustomTextField(
                  textEditingController: notifier.startDateController,
                  isFocus: provider.isOpenStartDatePicker,
                  enabled: false,
                  checkEmpty: true,
                  isDateAndTime: true,
                  fillColor: selectedVisit != null &&
                          selectedVisit!.visitStartDate!.isBeforeNow
                      ? grayE3
                      : whiteColor,
                  hintText: S.current.startingDate,
                  suffixIcon: const Icon(
                    Icons.calendar_today,
                    color: expireStatusColor,
                    size: 20,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 8.w,
            ),
            Expanded(
              child: InkWell(
                onTap: selectedVisit != null &&
                        selectedVisit!.visitStartDate!.isBeforeNow
                    ? null
                    : notifier.openStartTimePickerDialog,
                child: SecondCustomTextField(
                  textEditingController: notifier.startTimeController,
                  enabled: false,
                  fillColor: selectedVisit != null &&
                          selectedVisit!.visitStartDate!.isBeforeNow
                      ? grayE3
                      : whiteColor,
                  checkEmpty: true,
                  isDateAndTime: true,
                  isFocus: provider.isOpenStartTimePicker,
                  hintText: S.current.time,
                  suffixIcon: const Icon(
                    Icons.keyboard_arrow_down_sharp,
                    color: expireStatusColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
