import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/extensions/context_extensions.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/widget/custom_text_field.dart';
import 'package:pif_flutter/common/shared/widget/date_picker_widget.dart';
import 'package:pif_flutter/ui/visit/invite_visitor/index.dart';
import 'package:pif_flutter/ui/visit/invite_visitor/widget/invite_visitor_form_list_view.dart';
import 'package:pif_flutter/widgets/margin_widget.dart';
import 'package:pif_flutter/widgets/time_picker_popup.dart';

class InviteVisitorPage extends ConsumerStatefulWidget {
  const InviteVisitorPage({
    super.key,
  });

  @override
  ConsumerState createState() => _InviteVisitorPageState();
}

class _InviteVisitorPageState extends ConsumerState<InviteVisitorPage> {
  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(inviteVisitorProvider);
    final notifier = ref.read(inviteVisitorProvider.notifier);
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        automaticallyImplyLeading: false,
        centerTitle: false,
        titleSpacing: 0,
        elevation: 0,
        leading: IconButton(
          onPressed: AppRouter.pop,
          icon: SvgPicture.asset(
            Assets.back,
            height: 14.h,
          ),
        ),
        title: Text(
          S.of(context).inviteVisitors,
          style: Style.commonTextStyle(
            color: blackColor,
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          if (provider.isOpenStartDatePicker) {
            notifier.closeStartDatePickerDialog();
          }
          if (provider.isOpenEndDatePicker) {
            notifier.closeEndDatePickerDialog();
          }

          if (provider.isOpenStartTimePicker) {
            notifier.closeStartTimePickerDialog();
          }

          if (provider.isOpenEndTimePicker) {
            notifier.closeEndTimePickerDialog();
          }
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: SizedBox(
          height: context.screenHeight,
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Form(
                key: notifier.formKeyForDate,
                child: SingleChildScrollView(
                  child: Stack(
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: notifier.openStartDatePickerDialog,
                                  child: Theme(
                                    data: ThemeData(
                                      disabledColor: textColor,
                                    ),
                                    child: CustomTextField(
                                      textEditingController:
                                          notifier.startDateController,
                                      isFocus: provider.isOpenStartDatePicker,
                                      enabled: false,
                                      checkEmpty: true,
                                      labelText: S.current.startingDate,
                                      suffixIcon: SvgPicture.asset(
                                        Assets.calendar,
                                        height: 10.h,
                                        width: 10.w,
                                        fit: BoxFit.scaleDown,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              SvgPicture.asset(
                                Assets.arrowRightBack,
                                height: 12.h,
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: notifier.openStartTimePickerDialog,
                                  child: Theme(
                                    data: ThemeData(
                                      disabledColor: textColor,
                                    ),
                                    child: CustomTextField(
                                      textEditingController:
                                          notifier.startTimeController,
                                      enabled: false,
                                      checkEmpty: true,
                                      isFocus: provider.isOpenStartTimePicker,
                                      labelText: S.current.time,
                                      suffixIcon: SvgPicture.asset(
                                        Assets.arrowDown,
                                        height: 10.h,
                                        width: 10.w,
                                        fit: BoxFit.scaleDown,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          MarginWidget(
                            horizontal: -15,
                            child: Divider(
                              color: grayBorderColor,
                              height: 1.h,
                            ),
                          ),
                          SizedBox(
                            height: 25.h,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: notifier.openEndDatePickerDialog,
                                  child: Theme(
                                    data: ThemeData(
                                      disabledColor: textColor,
                                    ),
                                    child: CustomTextField(
                                      textEditingController:
                                          notifier.endDateController,
                                      isFocus: provider.isOpenEndDatePicker,
                                      enabled: false,
                                      checkEmpty: true,
                                      labelText: S.current.endingDate,
                                      suffixIcon: SvgPicture.asset(
                                        Assets.calendar,
                                        height: 10.h,
                                        width: 10.w,
                                        fit: BoxFit.scaleDown,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              SvgPicture.asset(
                                Assets.arrowRightBack,
                                height: 12.h,
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: notifier.openEndTimePickerDialog,
                                  child: Theme(
                                    data: ThemeData(
                                      disabledColor: textColor,
                                    ),
                                    child: CustomTextField(
                                      textEditingController:
                                          notifier.endTimeController,
                                      isFocus: provider.isOpenEndTimePicker,
                                      enabled: false,
                                      checkEmpty: true,
                                      labelText: S.current.time,
                                      suffixIcon: SvgPicture.asset(
                                        Assets.arrowDown,
                                        height: 10.h,
                                        width: 10.w,
                                        fit: BoxFit.scaleDown,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          MarginWidget(
                            horizontal: -15,
                            child: Divider(
                              color: grayBorderColor,
                              height: 1.h,
                            ),
                          ),
                          SizedBox(
                            height: 25.h,
                          ),
                          Row(
                            children: [
                              Text(
                                S.of(context).visitors,
                                style: Style.commonTextStyle(
                                  color: blackColor,
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const Spacer(),
                              TextButton(
                                onPressed: () => notifier.addPreviousVisitor(
                                  context: context,
                                ),
                                child: Text(
                                  S.of(context).addPreviousVisitor,
                                  style: Style.commonTextStyle(
                                    color: primaryColor,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          InviteVisitorFormListView(
                            notifier: notifier,
                            provider: provider,
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          TextButton(
                            onPressed: provider.isFieldDisable
                                ? null
                                : () =>
                                    notifier.addMoreVisitor(context: context),
                            child: Text(
                              S.of(context).addMoreVisitors,
                              style: Style.commonTextStyle(
                                color: provider.isFieldDisable
                                    ? primaryDisabledColor
                                    : primaryColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          ElevatedButton(
                            onPressed: () => notifier.sendInvitation(context),
                            style: Style.primaryButtonStyle(
                              context: context,
                              primaryColor: provider.isFieldDisable
                                  ? primaryDisabledColor
                                  : primaryColor,
                            ),
                            child: Text(
                              S.of(context).sendInvitation,
                            ),
                          )
                        ],
                      ),
                      Visibility(
                        visible: provider.isOpenStartDatePicker,
                        child: Padding(
                          padding: EdgeInsets.only(top: 10.h),
                          child: InkWell(
                            onTap: () {},
                            child: DatePickerWidget(
                              selectedDate: provider.startDate,
                              onConfirm: notifier.updateStartDate,
                              onCancel: notifier.closeStartDatePickerDialog,
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: provider.isOpenStartTimePicker,
                        child: Padding(
                          padding: EdgeInsets.only(top: 60.h),
                          child: InkWell(
                            onTap: () {},
                            child: TimePickerPopup(
                              timeData: provider.startTime,
                              timeGap: TimeGap.oneHour,
                              onCancel: notifier.closeStartTimePickerDialog,
                              onConfirm: (selectedTime) {
                                notifier.updateStartTime(
                                  startTime: selectedTime,
                                );
                                notifier.closeStartTimePickerDialog();
                              },
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: provider.isOpenEndDatePicker,
                        child: Padding(
                          padding: EdgeInsets.only(top: 105.h),
                          child: InkWell(
                            onTap: () {},
                            child: DatePickerWidget(
                              selectedDate: provider.endDate,
                              onConfirm: notifier.updateEndDate,
                              onCancel: notifier.closeEndDatePickerDialog,
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: provider.isOpenEndTimePicker,
                        child: Padding(
                          padding: EdgeInsets.only(top: 155.h),
                          child: InkWell(
                            onTap: () {},
                            child: TimePickerPopup(
                              timeData: provider.endTime,
                              timeGap: TimeGap.oneHour,
                              onCancel: notifier.closeEndTimePickerDialog,
                              onConfirm: (selectedTime) {
                                notifier.updateEndTime(endTime: selectedTime);
                                notifier.closeEndTimePickerDialog();
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
