import 'package:dixels_sdk/features/commerce/visit/models/visit_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/extensions/context_extensions.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/widget/background_widget.dart';
import 'package:pif_flutter/common/shared/widget/custom_app_bar.dart';
import 'package:pif_flutter/common/shared/widget/date_picker_widget.dart';
import 'package:pif_flutter/ui/visit/invite_edit_visit/index.dart';
import 'package:pif_flutter/ui/visit/invite_edit_visit/widget/end_date_and_time.dart';
import 'package:pif_flutter/ui/visit/invite_edit_visit/widget/invite_visitor_form_list_view.dart';
import 'package:pif_flutter/ui/visit/invite_edit_visit/widget/start_date_and_time.dart';
import 'package:pif_flutter/widgets/time_picker_popup.dart';

class InviteEditVisitPage extends ConsumerStatefulWidget {
  const InviteEditVisitPage({
    required this.fromHomepage,
    this.isInviteVisit = true,
    this.selectedVisit,
    super.key,
  });

  final bool fromHomepage;
  final bool isInviteVisit;
  final VisitModel? selectedVisit;

  @override
  ConsumerState createState() => _InviteVisitorPageState();
}

class _InviteVisitorPageState extends ConsumerState<InviteEditVisitPage> {
  @override
  void initState() {
    super.initState();
    final notifier = ref.read(inviteVisitorProvider.notifier);
    Future.delayed(
      Duration.zero,
      () => notifier.fillStartDateAndEndDate(visitModel: widget.selectedVisit),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(inviteVisitorProvider);
    final notifier = ref.read(inviteVisitorProvider.notifier);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
        title: S.current.inviteVisitors,
      ),
      body: BackgroundWidget(
        child: GestureDetector(
          onTap: () => notifier.checkIfAnyDateOrTimeIsOpen()
              ? notifier.closeDateAndTime()
              : null,
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: 23.h,
                            ),
                            Text(
                              S.current.dateAndTime,
                              style: Style.commonTextStyle(
                                color: blackColorWith900,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            StartDateAndTime(
                              notifier: notifier,
                              provider: provider,
                              selectedVisit: widget.selectedVisit,
                            ),
                            SizedBox(height: 8.h),
                            EndDateAndTime(
                              notifier: notifier,
                              provider: provider,
                              selectedVisit: widget.selectedVisit,
                            ),
                            SizedBox(
                              height: 24.h,
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      S.current.visitInformation,
                                      style: Style.commonTextStyle(
                                        color: blackColorWith900,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const Spacer(),
                                    TextButton(
                                      onPressed: () =>
                                          notifier.addPreviousVisitor(
                                        context: context,
                                      ),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.add,
                                            color: primary700,
                                            size: 18,
                                          ),
                                          SizedBox(width: 3.w),
                                          Text(
                                            S.current.previousVisitors,
                                            style: Style.commonTextStyle(
                                              color: primaryColor,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16.h),
                              ],
                            ).visibility(visible: widget.isInviteVisit),
                            InviteVisitorFormListView(
                              notifier: notifier,
                              provider: provider,
                              isInviteVisit: widget.isInviteVisit,
                            ),
                            SizedBox(
                              height: 40.h,
                            ),
                            ElevatedButton(
                              style:
                                  Style.secondaryButtonStyle(context: context),
                              onPressed: provider.isFieldDisable
                                  ? () {}
                                  : () =>
                                      notifier.addMoreVisitor(context: context),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.add,
                                    color: primaryColor,
                                    size: 20,
                                  ),
                                  SizedBox(width: 5.w),
                                  Text(
                                    S.current.moreVisitors,
                                    style: Style.commonTextStyle(
                                      color: primaryColor,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ).visibility(
                              visible: widget.isInviteVisit,
                            ),
                            SizedBox(height: 100.h),
                          ],
                        ),
                        Visibility(
                          visible: provider.isOpenStartDatePicker,
                          child: Padding(
                            padding: EdgeInsets.only(top: 10.h),
                            child: DatePickerWidget(
                              selectedDate: provider.startDate,
                              onConfirm: notifier.updateStartDate,
                              onCancel: notifier.closeStartDatePickerDialog,
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
                            child: DatePickerWidget(
                              selectedDate: provider.endDate,
                              onConfirm: notifier.updateEndDate,
                              onCancel: notifier.closeEndDatePickerDialog,
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
                                  notifier.updateEndTime(
                                    endTime: selectedTime,
                                  );
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
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: ElevatedButton(
          onPressed: widget.isInviteVisit
              ? () => notifier.sendAndEditInvitation(
                    context: context,
                    fromHomepage: widget.fromHomepage,
                  )
              : () => notifier.sendAndEditInvitation(
                    context: context,
                    fromHomepage: widget.fromHomepage,
                    isEditVisit: true,
            visitId: widget.selectedVisit?.id,
                  ),
          style: Style.primaryButtonStyleSecond(
            context: context,
            primaryColor: widget.isInviteVisit
                ? provider.isFieldDisable
                    ? primaryDisabledColor
                    : primaryColor
                : primaryColor,
          ),
          child: Text(
            widget.isInviteVisit
                ? S.current.sendInvitation
                : S.current.editVisit,
          ),
        ),
      ),
    );
  }
}
