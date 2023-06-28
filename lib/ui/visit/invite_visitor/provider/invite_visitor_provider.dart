import 'package:collection/collection.dart';
import 'package:dixels_sdk/dixels_sdk.dart';
import 'package:dixels_sdk/features/commerce/visit/models/visit_model.dart';
import 'package:dixels_sdk/features/commerce/visit/models/visit_param.dart' as visit;
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pif_flutter/common/extensions/string_extensions.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/message/progress_dialog.dart';
import 'package:pif_flutter/common/shared/message/success_message.dart';
import 'package:pif_flutter/common/shared/message/toast_message.dart';
import 'package:pif_flutter/routes/routes.dart';
import 'package:pif_flutter/ui/visit/invite_visitor/index.dart';
import 'package:pif_flutter/ui/visit/invite_visitor/popup/previous_visitor_popup.dart';
import 'package:pif_flutter/ui/visit/invite_visitor/provider/previous_visitor_provider.dart';
import 'package:pif_flutter/ui/visit/visit_list/provider/visit_list_provider.dart';

final inviteVisitorProvider =
    StateNotifierProvider.autoDispose<InviteVisitorNotifier, InviteVisitorState>((ref) {
  return InviteVisitorNotifier(ref: ref);
});

class InviteVisitorNotifier extends StateNotifier<InviteVisitorState> {
  InviteVisitorNotifier({required this.ref}) : super(InviteVisitorState.initial()) {
    _initData();
  }

  final Ref ref;
  late FocusNode firstNameFocus;
  late FocusNode lastNameFocus;
  late FocusNode emailFocus;
  late GlobalKey<FormState> formKey;
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController startDateController;
  late TextEditingController startDateSelectController;
  late TextEditingController endDateSelectController;
  late TextEditingController endDateController;
  late TextEditingController startTimeController;
  late TextEditingController endTimeController;

  void _initData() {
    firstNameFocus = FocusNode();
    lastNameFocus = FocusNode();
    emailFocus = FocusNode();

    lastNameFocus.addListener(_onNameFocus);
    firstNameFocus.addListener(_onNameFocus);
    emailFocus.addListener(_onNameFocus);

    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    startTimeController = TextEditingController();
    endTimeController = TextEditingController();
    startDateController = TextEditingController();
    endDateController = TextEditingController();
    startDateSelectController = TextEditingController();
    endDateSelectController = TextEditingController();
    formKey = GlobalKey<FormState>();

    _setDefaultDateTime();
  }

  void onChangeText(String text) {
    _updateDisableFields();
  }

  // Check text
  bool checkEntryData({required BuildContext context}) {
    if (state.lstData.isEmpty && !state.isFieldDisable && emailController.text.isValidEmail()) {
      if (visitorNotFoundFromVisitorHistory(email: emailController.text)) {
        final lstData = state.lstData.toList();
        final visitor = InviteVisitorModel(
          firstNameController.text,
          lastNameController.text,
          emailController.text,
          'Verified',
        );
        lstData.add(visitor);
        state = state.copyWith(lstData: lstData);
        firstNameController.clear();
        lastNameController.clear();
        emailController.clear();
        return true;
      } else {
        errorMessage(
          errorMessage: S.current.visitorAlreadyFound,
          context: context,
        );
        return false;
      }
    } else {
      return true;
    }
  }

  //Add Previous Visitor
  Future<void> addPreviousVisitor({required BuildContext context}) async {
    if (checkEntryData(context: context)) {
      final previousProvider = ref.read(previousVisitorProvider);
      await previousVisitorPopup(context: context);

      final selectedData = previousProvider.lstData.where((element) => element.isSelected == true).toList();

      final lstData = state.lstData.toList();
      for (final item in selectedData) {
        final data = lstData.firstWhereOrNull(
          (element) => element.email!.toLowerCase() == item.email!.toLowerCase(),
        );
        if (data == null) {
          lstData.add(item);
        }
      }

      state = state.copyWith(lstData: lstData);

      _updateDisableFields();
    } else {
      // await appProgressDialog.stop();
    }
  }

  //Add More Visitor
  void addMoreVisitor({required BuildContext context}) {
    if (state.isFieldDisable) {
      return;
    }
    if (checkEntryData(context: context)) {
      addMoreVisitorPopup(context: context);
    }
  }

  //Send Invitation
  void sendInvitation(BuildContext context) {
    if (state.isFieldDisable) {
      return;
    }
    if (state.startDate.isAfter(state.endDate)) {
      errorMessage(
        context: context,
        errorMessage: S.current.dateTimeCompareMsg,
      );
      return;
    }
    final startDate = DateFormat('yyyy-MM-dd hh:mm a').parse(
      '${startDateSelectController.text} ${startTimeController.text}'.replaceAll('pm', 'PM').replaceAll('am', 'AM'),
    );
    final endDate = DateFormat('yyyy-MM-dd hh:mm a').parse(
      '${endDateSelectController.text} ${endTimeController.text}'.replaceAll('pm', 'PM').replaceAll('am', 'AM'),
    );

    if (formKey.currentState!.validate()) {
      inviteVisitorApi(
        context: context,
        startDate: startDate,
        endDate: endDate,
      );
    }
  }

  //Check if visitor not found
  bool visitorNotFoundLocally({required String email}) {
    if (state.lstData
            .where(
              (visitor) => visitor.email?.toLowerCase() == email.toLowerCase(),
            )
            .firstOrNull ==
        null) {
      return true;
    } else {
      return false;
    }
  }

  //Check if visitor not found from history
  bool visitorNotFoundFromVisitorHistory({required String email}) {
    final previousProvider = ref.read(previousVisitorProvider);
    if (previousProvider.lstData
            .where(
              (visitor) => visitor.email?.toLowerCase() == email.toLowerCase(),
            )
            .firstOrNull ==
        null) {
      return true;
    } else {
      return false;
    }
  }

  //Add Visitor
  void addVisitorFromAddMoreVisitor({
    required BuildContext context,
    required InviteVisitorModel item,
  }) {
    if (visitorNotFoundLocally(email: item.email ?? '') &&
        visitorNotFoundFromVisitorHistory(email: item.email ?? '')) {
      final lstData = state.lstData.toList();
      lstData.add(item);
      state = state.copyWith(lstData: lstData);
      _updateDisableFields();
      AppRouter.pop();
    } else {
      errorMessage(
        errorMessage: S.current.visitorAlreadyFound,
        context: context,
      );
    }
  }

  //Remove Visitor List Item
  void removeVisitor(InviteVisitorModel item) {
    final data = state.lstData.toList();
    data.remove(item);

    state = state.copyWith(lstData: data);

    _updateDisableFields();
  }

  void _updateDisableFields() {
    final isDisable = state.lstData.isEmpty &&
        (firstNameController.text.isEmpty || lastNameController.text.isEmpty || emailController.text.isEmpty);
    state = state.copyWith(isFieldDisable: isDisable);
  }

  //Update Start Date
  void updateStartDate(DateTime date) {
    state = state.copyWith(startDate: date);
    startDateController.text = DateFormat('MM/dd/yyyy').format(date);
    startDateSelectController.text = DateFormat('yyyy-MM-dd').format(date);

    state = state.copyWith(endDate: date);
    endDateController.text = DateFormat('MM/dd/yyyy').format(date);
    endDateSelectController.text = DateFormat('yyyy-MM-dd').format(date);

    closeStartDatePickerDialog();
  }

  //Update End Date
  void updateEndDate(DateTime date) {
    state = state.copyWith(endDate: date);
    endDateController.text = DateFormat('MM/dd/yyyy').format(date);
    endDateSelectController.text = DateFormat('yyyy-MM-dd').format(date);

    closeEndDatePickerDialog();
  }

  //Update Start Time
  void updateStartTime({required DateTime? startTime}) {
    startTime = DateTime(
      startTime!.year,
      startTime.month,
      startTime.day,
      startTime.hour,
      startTime.minute,
    );

    state = state.copyWith(startTime: startTime);
    final startTimeString = DateFormat('hh:mm a').format(startTime);
    startTimeController.text = startTimeString;
  }

  //Update End Time
  void updateEndTime({required DateTime? endTime}) {
    endTime = DateTime(
      endTime!.year,
      endTime.month,
      endTime.day,
      endTime.hour,
      endTime.minute,
    );

    state = state.copyWith(endTime: endTime);
    final endTimeString = DateFormat('hh:mm a').format(endTime);
    endTimeController.text = endTimeString;
  }

  //Open Start DatePicker Dialog
  void openStartDatePickerDialog() {
    if (state.isOpenStartTimePicker ||
        state.isOpenEndTimePicker ||
        state.isOpenEndDatePicker ||
        firstNameFocus.hasFocus ||
        lastNameFocus.hasFocus ||
        emailFocus.hasFocus) {
      return;
    }
    state = state.copyWith(isOpenStartDatePicker: true);
  }

  //Close Start DatePicker Dialog
  void closeStartDatePickerDialog() {
    state = state.copyWith(isOpenStartDatePicker: false);
  }

  //Open End DatePicker Dialog
  void openEndDatePickerDialog() {
    if (state.isOpenEndTimePicker || firstNameFocus.hasFocus || lastNameFocus.hasFocus || emailFocus.hasFocus) {
      return;
    }
    state = state.copyWith(isOpenEndDatePicker: true);
  }

  //Close End DatePicker Dialog
  void closeEndDatePickerDialog() {
    state = state.copyWith(isOpenEndDatePicker: false);
  }

  //Open StartTime Picker Dialog
  void openStartTimePickerDialog() {
    if (state.isOpenStartDatePicker ||
        state.isOpenEndTimePicker ||
        state.isOpenEndDatePicker ||
        firstNameFocus.hasFocus ||
        lastNameFocus.hasFocus ||
        emailFocus.hasFocus) {
      return;
    }
    state = state.copyWith(isOpenStartTimePicker: true);
  }

  //Close StartTime Picker Dialog
  void closeStartTimePickerDialog() {
    state = state.copyWith(isOpenStartTimePicker: false);
  }

  //Open EndTime Picker Dialog
  void openEndTimePickerDialog() {
    if (state.isOpenEndDatePicker || firstNameFocus.hasFocus || lastNameFocus.hasFocus || emailFocus.hasFocus) {
      return;
    }
    state = state.copyWith(isOpenEndTimePicker: true);
  }

  //Close EndTime Picker Dialog
  void closeEndTimePickerDialog() {
    state = state.copyWith(isOpenEndTimePicker: false);
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    startTimeController.dispose();
    startDateController.dispose();
    endDateController.dispose();
    endTimeController.dispose();
    super.dispose();
  }

  void _setDefaultDateTime() {
    final dateTime = DateTime.now();
    final minute = dateTime.minute;
    final minuteModulo = minute % 60;
    var roundedTime = dateTime.subtract(Duration(minutes: minuteModulo));

    roundedTime = DateTime(
      roundedTime.year,
      roundedTime.month,
      roundedTime.day,
      roundedTime.hour,
      roundedTime.minute,
    );

    updateStartTime(startTime: roundedTime);
    updateEndTime(endTime: roundedTime.add(const Duration(hours: 1)));
  }

  Future<void> inviteVisitorApi({
    required BuildContext context,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final appProgressDialog = AppProgressDialog(context: context);
    await appProgressDialog.start();
    final result = await DixelsSDK.instance.visitService.postPageDataWithEither(
      reqModel: visit.VisitParam(
        state: visit.State(key: 'pendingVerification'),
        visitStartDate: startDate.toIso8601String(),
        visitEndDate: endDate.toIso8601String(),
        visitors: state.lstData.isNotEmpty
            ? state.lstData
                .map(
                  (e) => visit.Visitors(
                    givenName: e.firstName ?? '',
                    familyName: e.lastName ?? '',
                    emailAddress: e.email ?? '',
                    alternateName: e.email!.substring(0, e.email!.indexOf('@')),
                  ),
                )
                .toList()
            : [
                visit.Visitors(
                  emailAddress: emailController.text,
                  alternateName: emailController.text.substring(0, emailController.text.indexOf('@')),
                  givenName: firstNameController.text,
                  familyName: lastNameController.text,
                ),
              ],
      ),
      fromJson: VisitModel.fromJson,
    );
    await appProgressDialog.stop();
    if (result.isRight()) {
      final notifier = ref.read(visitListProvider.notifier);
      showSuccessMessage(
        context: context,
        titleText: S.current.inviteVisitor,
        subTitle: S.current.inviteByMistake,
        navigateAfterEndTime: () {
          notifier.getVisits();
          AppRouter.popUntil(Routes.visitListScreen);
        },
      );
    } else {
      errorMessage(
        errorMessage: S.current.visitorAlreadyFound,
        context: context,
      );
    }
  }

  void _onNameFocus() {
    closeEndDatePickerDialog();
    closeStartDatePickerDialog();
    closeStartTimePickerDialog();
    closeEndTimePickerDialog();
  }
}
