import 'package:collection/collection.dart';
import 'package:dixels_sdk/common/models/parameters_model.dart';
import 'package:dixels_sdk/dixels_sdk.dart';
import 'package:dixels_sdk/features/commerce/visit/models/edit_visit_param.dart';
import 'package:dixels_sdk/features/commerce/visit/models/visit_model.dart';
import 'package:dixels_sdk/features/commerce/visit/models/visit_param.dart'
    as visit;
import 'package:dixels_sdk/features/commerce/visit/models/visitor_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pif_flutter/common/extensions/string_extensions.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/message/progress_dialog.dart';
import 'package:pif_flutter/common/shared/message/slider_success_message.dart';
import 'package:pif_flutter/common/shared/message/toast_message.dart';
import 'package:pif_flutter/helpers/filter_utils.dart';
import 'package:pif_flutter/routes/routes.dart';
import 'package:pif_flutter/ui/visit/invite_edit_visit/index.dart';
import 'package:pif_flutter/ui/visit/invite_edit_visit/popup/previous_visitor_popup.dart';
import 'package:pif_flutter/ui/visit/invite_edit_visit/provider/previous_visitor_provider.dart';
import 'package:pif_flutter/ui/visit/visit_list/provider/visit_list_provider.dart';

final inviteVisitorProvider = StateNotifierProvider.autoDispose<
    InviteVisitorNotifier, InviteEditVisitState>((ref) {
  return InviteVisitorNotifier(ref: ref);
});

class InviteVisitorNotifier extends StateNotifier<InviteEditVisitState> {
  InviteVisitorNotifier({required this.ref})
      : super(InviteEditVisitState.initial()) {
    _initData();
  }

  final Ref ref;
  FocusNode firstNameFocus = FocusNode();
  FocusNode lastNameFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  late GlobalKey<FormState> formKeyForDate;
  late GlobalKey<FormState> formKeyForVisitor;
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
    formKeyForDate = GlobalKey<FormState>();
    getVisitorHistory();
  }

  void onChangeText(String text) {
    _updateDisableFields();
  }

  void fillStartDateAndEndDate({
    required BuildContext context,
    VisitModel? visitModel,
  }) {
    if (visitModel != null) {
      updateStartDate(visitModel.visitStartDate!);
      updateEndDate(
        date: visitModel.visitEndDate!,
        context: context,
      );
      updateStartTime(startTime: visitModel.visitStartDate);
      updateEndTime(endTime: visitModel.visitEndDate, context: context);
    }
  }

  // Check text
  bool checkEntryData({
    required BuildContext context,
  }) {
    if (state.lstData.isEmpty &&
        !state.isFieldDisable &&
        emailController.text.isValidEmail()) {
      if (visitorNotFoundFromVisitorHistory(email: emailController.text)) {
        final lstData = state.lstData.toList();
        final visitor = InviteVisitorModel(
          firstNameController.text,
          lastNameController.text,
          emailController.text,
          isVisitorVerified: false,
          fromHistory: false,
        );
        lstData.add(visitor);
        state = state.copyWith(lstData: lstData);
        firstNameController.clear();
        lastNameController.clear();
        emailController.clear();
        return true;
      } else {
        alertMessage(
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
      final previousVisitorSelected =
          await previousVisitorPopup(context: context);
      final lstData = state.lstData.toList();
      for (final item in previousVisitorSelected) {
        final data = lstData.firstWhereOrNull(
          (element) =>
              element.email!.toLowerCase() == item.email!.toLowerCase(),
        );
        if (data == null) {
          lstData.add(item);
        }
      }
      state = state.copyWith(lstData: lstData);
      _updateDisableFields();
    }
  }

  //Add More Visitor
  void addMoreVisitor({required BuildContext context}) {
    if (checkEntryData(context: context)) {
      addMoreVisitorPopup(
        context: context,
      );
    }
  }

  //Send Invitation
  void sendAndEditInvitation({
    required BuildContext context,
    required bool fromHomepage,
    bool isEditVisit = false,
    int? visitId,
  }) {
    if (formKeyForDate.currentState!.validate()) {
      if (!isEditVisit) {
        if (state.isFieldDisable) {
          return;
        }
      }

      if (state.startDate!.isAfter(state.endDate!)) {
        alertMessage(
          context: context,
          errorMessage: S.current.dateTimeCompareMsg,
        );
        return;
      }

      final startDate = DateFormat('yyyy-MM-dd hh:mm a').parse(
        '${startDateSelectController.text} ${startTimeController.text}'
            .replaceAll('pm', 'PM')
            .replaceAll('am', 'AM'),
      );
      final endDate = DateFormat('yyyy-MM-dd hh:mm a').parse(
        '${endDateSelectController.text} ${endTimeController.text}'
            .replaceAll('pm', 'PM')
            .replaceAll('am', 'AM'),
      );
      if (startDate.isAfter(endDate) || startDate.isAtSameMomentAs(endDate)) {
        alertMessage(
          context: context,
          errorMessage: S.current.dateTimeCompareMsgTime,
        );
        return;
      }
      if (!isEditVisit) {
        inviteVisitorApi(
          context: context,
          startDate: startDate,
          endDate: endDate,
          fromHomepage: fromHomepage,
        );
      } else {
        editVisitAPI(
          context: context,
          startDate: startDate,
          endDate: endDate,
          visitId: visitId!,
        );
      }
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

  void closeDateAndTime() {
    state = state.copyWith(isOpenStartDatePicker: false);
    state = state.copyWith(isOpenEndDatePicker: false);
    state = state.copyWith(isOpenStartTimePicker: false);
    state = state.copyWith(isOpenEndTimePicker: false);
    FocusManager.instance.primaryFocus?.unfocus();
  }

  bool checkIfAnyDateOrTimeIsOpen() {
    if (state.isOpenStartDatePicker ||
        state.isOpenEndDatePicker ||
        state.isOpenStartTimePicker ||
        state.isOpenEndTimePicker ||
        firstNameFocus.hasFocus ||
        emailFocus.hasFocus ||
        lastNameFocus.hasFocus) {
      return true;
    } else {
      return false;
    }
  }

  //Check if visitor not found from history
  bool visitorNotFoundFromVisitorHistory({required String email}) {
    final previousProvider = ref.read(previousVisitorProvider);
    if (previousProvider.previousVisitorList.value!
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
    //Check if visitor found
    if (visitorNotFoundLocally(email: item.email ?? '') &&
        visitorNotFoundFromVisitorHistory(email: item.email ?? '')) {
      final lstData = state.lstData.toList();
      lstData.add(item);
      state = state.copyWith(lstData: lstData);
      _updateDisableFields();
      AppRouter.pop();
    } else {
      alertMessage(
        errorMessage: S.current.visitorAlreadyFound,
        context: context,
      );
    }
  }

  //Remove Visitor List Item
  void removeVisitor(InviteVisitorModel item) {
    final data = state.lstData.toList();
    data.removeWhere((visitor) => visitor.email == item.email);

    state = state.copyWith(lstData: data);

    _updateDisableFields();
  }

  void _updateDisableFields() {
    final isDisable = state.lstData.isEmpty &&
        (firstNameController.text.isEmpty ||
            lastNameController.text.isEmpty ||
            emailController.text.isEmpty);
    state = state.copyWith(isFieldDisable: isDisable);
  }

  //Update Start Date
  void updateStartDate(DateTime date) {
    state = state.copyWith(startDate: date);
    startDateController.text = DateFormat('dd/MM/yyyy').format(date);
    startDateSelectController.text = DateFormat('yyyy-MM-dd').format(date);

    closeStartDatePickerDialog();
  }

  //Update End Date
  void updateEndDate({
    required DateTime date,
    required BuildContext context,
  }) {
    if (startDateController.text != '' && startTimeController.text != '') {
      final startDate = DateFormat('yyyy-MM-dd hh:mm a').parse(
        '${startDateSelectController.text} ${startTimeController.text}'
            .replaceAll('pm', 'PM')
            .replaceAll('am', 'AM'),
      );
      final endDate = endTimeController.text != ''
          ? DateFormat('yyyy-MM-dd hh:mm a').parse(
              '${DateFormat('yyyy-MM-dd').format(date)} ${endTimeController.text}'
                  .replaceAll('pm', 'PM')
                  .replaceAll('am', 'AM'),
            )
          : date;
      if (startDate.isAfter(endDate) || startDate.isAtSameMomentAs(endDate)) {
        alertMessage(
          context: context,
          errorMessage: S.current.dateTimeCompareMsgTime,
        );
        return;
      }
      state = state.copyWith(endDate: date);
      endDateController.text = DateFormat('dd/MM/yyyy').format(date);
      endDateSelectController.text = DateFormat('yyyy-MM-dd').format(date);

      closeEndDatePickerDialog();
    } else {
      alertMessage(
        errorMessage: S.current.selectStartDateAndTime,
        context: context,
      );
    }
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
  void updateEndTime({
    required DateTime? endTime,
    required BuildContext context,
  }) {
    endTime = DateTime(
      endTime!.year,
      endTime.month,
      endTime.day,
      endTime.hour,
      endTime.minute,
    );
    if (startTimeController.text != '' &&
        startDateSelectController.text != '') {
      final endTimeString = DateFormat('hh:mm a').format(endTime);
      final startDate = DateFormat('yyyy-MM-dd hh:mm a').parse(
        '${startDateSelectController.text} ${startTimeController.text}'
            .replaceAll('pm', 'PM')
            .replaceAll('am', 'AM'),
      );
      if (endDateController.text != '') {
        final endDate = DateFormat('yyyy-MM-dd hh:mm a').parse(
          '${endDateSelectController.text} $endTimeString'
              .replaceAll('pm', 'PM')
              .replaceAll('am', 'AM'),
        );
        if (startDate.isAfter(endDate) || startDate.isAtSameMomentAs(endDate)) {
          alertMessage(
            context: context,
            errorMessage: S.current.dateTimeCompareMsgTime,
          );
          return;
        }
      }
      state = state.copyWith(endTime: endTime);

      endTimeController.text = endTimeString;
      closeEndTimePickerDialog();
    } else {
      alertMessage(
        errorMessage: S.current.selectStartDateAndTime,
        context: context,
      );
    }
  }

  //Open Start DatePicker Dialog
  void openStartDatePickerDialog({required BuildContext context}) {
    if (checkIfAnyDateOrTimeIsOpen()) {
      closeDateAndTime();
    }
    Future.delayed(Duration.zero, () {
      state = state.copyWith(isOpenStartDatePicker: true);
    });
  }

  //Close Start DatePicker Dialog
  void closeStartDatePickerDialog() {
    state = state.copyWith(isOpenStartDatePicker: false);
  }

  //Open End DatePicker Dialog
  void openEndDatePickerDialog() {
    if (checkIfAnyDateOrTimeIsOpen()) {
      closeDateAndTime();
    }
    Future.delayed(Duration.zero, () {
      state = state.copyWith(isOpenEndDatePicker: true);
    });
  }

  //Close End DatePicker Dialog
  void closeEndDatePickerDialog() {
    state = state.copyWith(isOpenEndDatePicker: false);
  }

  //Open StartTime Picker Dialog
  void openStartTimePickerDialog() {
    if (checkIfAnyDateOrTimeIsOpen()) {
      closeDateAndTime();
    }
    Future.delayed(Duration.zero, () {
      state = state.copyWith(isOpenStartTimePicker: true);
    });
  }

  //Close StartTime Picker Dialog
  void closeStartTimePickerDialog() {
    state = state.copyWith(isOpenStartTimePicker: false);
  }

  //Open EndTime Picker Dialog
  void openEndTimePickerDialog() {
    if (checkIfAnyDateOrTimeIsOpen()) {
      closeDateAndTime();
    }
    Future.delayed(Duration.zero, () {
      state = state.copyWith(isOpenEndTimePicker: true);
    });
  }

  //Close EndTime Picker Dialog
  void closeEndTimePickerDialog() {
    state = state.copyWith(isOpenEndTimePicker: false);
  }

  void setDefaultDateTime() {
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
  }

  void fetchVisitor({required VisitModel selectedVisit}) {
    state = state.copyWith(
      lstData: selectedVisit.visitors!
          .map(
            (e) => InviteVisitorModel(
              e.givenName,
              e.familyName,
              e.emailAddress,
              fromHistory: true,
              isVisitorVerified: true,
            ),
          )
          .toList(),
    );
  }

  void onRemoveFocusEmail({
    required BuildContext context,
    required TextEditingController emailController,
    bool isFromAddMoreVisitor = false,
  }) {
    if (emailController.text.isNotEmpty) {
      if (isFromAddMoreVisitor) {
        if (!visitorNotFoundLocally(email: emailController.text ?? '')) {
          alertMessage(
            errorMessage: S.current.visitorAlreadyFound,
            context: context,
          );
          return;
        }
      }
      final previousProvider = ref.read(previousVisitorProvider);
      if (!visitorNotFoundFromVisitorHistory(email: emailController.text)) {
        final visitor = previousProvider.previousVisitorList.value!
            .where(
              (visitor) =>
                  visitor.email?.toLowerCase() ==
                  emailController.text.toLowerCase(),
            )
            .first;
        emailController.clear();
        final lstData = state.lstData.toList();
        lstData.add(visitor);
        if (isFromAddMoreVisitor) {
          AppRouter.pop();
        }
        state = state.copyWith(lstData: lstData);
      }
    }
  }

  Future<void> checkIfUserIsVisitor({
    required BuildContext context,
    required TextEditingController emailControllerInput,
    bool isFromAddMoreVisitor = false,
  }) async {
    if (emailControllerInput.text != '') {
      final appProgress = AppProgressDialog(context: context);
      await appProgress.start();
      final param = ParametersModel();
      param.query = '?email=${emailControllerInput.text}';
      final result =
          await DixelsSDK.instance.verifyUserService.checkIfUserAlreadyFound(
        params: param,
      );
      await appProgress.stop();
      if (result.isRight()) {
        if (result.getRight()?.status == 'OK' &&
            result.getRight()!.user != null &&
            result
                    .getRight()!
                    .user!
                    .roleBriefs!
                    .where(
                      (element) => element.name == 'Visitor',
                    )
                    .firstOrNull ==
                null) {
          alertMessage(
            errorMessage: S.current.userAlreadyFound,
            context: context,
          );
          return;
        }
        onRemoveFocusEmail(
          context: context,
          emailController: emailControllerInput,
          isFromAddMoreVisitor: isFromAddMoreVisitor,
        );
      } else {
        alertMessage(
          errorMessage: result.getLeft().message,
          context: context,
        );
      }
    }
  }

  Future<void> inviteVisitorApi({
    required BuildContext context,
    required DateTime startDate,
    required DateTime endDate,
    required bool fromHomepage,
  }) async {
    if (checkEntryData(context: context)) {
      final appProgressDialog = AppProgressDialog(context: context);
      final visitorFromHistoryList = state.lstData.isNotEmpty
          ? state.lstData.where((visitor) => visitor.fromHistory).toList()
          : <InviteVisitorModel>[];
      final visitorAddedLocallyList = state.lstData.isNotEmpty
          ? state.lstData.where((visitor) => !visitor.fromHistory).toList()
          : <InviteVisitorModel>[];
      showSuccessSliding(
        context: context,
        titleText: S.current.inviteVisitor,
        navigateAfterEndTime: () async {
          await appProgressDialog.start();
          final result =
              await DixelsSDK.instance.visitService.postPageDataWithEither(
            reqModel: visit.VisitParam(
              visitStartDate: startDate.toIso8601String(),
              visitEndDate: endDate.toIso8601String(),
              visitors: visitorAddedLocallyList
                  .map(
                    (e) => visit.Visitors(
                      givenName: e.firstName ?? '',
                      familyName: e.lastName ?? '',
                      emailAddress: e.email ?? '',
                      alternateName: e.email!.replaceAll('@', '.'),
                    ),
                  )
                  .toList(),
            ),
            fromJson: VisitModel.fromJson,
          );
          if (visitorFromHistoryList.isNotEmpty) {
            for (final visitorFromHistory in visitorFromHistoryList) {
              final param = ParametersModel(
                filter: FilterUtils.filterBy(
                  key: 'emailAddress',
                  value: "'${visitorFromHistory.email}'",
                  operator: FilterOperator.equal.value,
                ),
              );
              final userInformation = await DixelsSDK.instance.accountService
                  .getUserByEmail(param: param);
              if (userInformation.isRight()) {
                final addVisitorHistory =
                    await DixelsSDK.instance.visitService.addVisitorByAccountId(
                  visitId: result.getRight()!.id,
                  accountId: userInformation.getRight()?.items?.first.id ?? 0,
                );
                if (addVisitorHistory.isRight()) {
                } else {
                  await appProgressDialog.stop();
                  alertMessage(
                    errorMessage: addVisitorHistory.getLeft().message,
                    context: context,
                  );
                  return;
                }
              } else {
                await appProgressDialog.stop();
                alertMessage(
                  errorMessage: userInformation.getLeft().message,
                  context: context,
                );
                return;
              }
            }
          }
          await appProgressDialog.stop();
          if (result.isRight()) {
            final notifier = ref.read(visitListProvider.notifier);
            alertMessage(
              errorMessage: S.current.inviteVisitorSuccess,
              context: context,
              statusEnum: AlertStatusEnum.success,
            );
            if (fromHomepage) {
              AppRouter.popUntil(Routes.dashboardScreen);
            } else {
              AppRouter.popUntil(Routes.visitListScreen);
              await notifier.getVisits();
            }
          } else {
            alertMessage(
              errorMessage: result.getLeft().message,
              context: context,
            );
          }
        },
      );
    }
  }

  Future<void> editVisitAPI({
    required BuildContext context,
    required DateTime startDate,
    required DateTime endDate,
    required int visitId,
  }) async {
    final appProgressDialog = AppProgressDialog(context: context);
    await appProgressDialog.start();
    final result = await DixelsSDK.instance.visitService.editVisit(
      visitId: visitId,
      editVisitParam: EditVisitParam(
        visitStartDate: startDate.toIso8601String(),
        visitEndDate: endDate.toIso8601String(),
      ),
    );
    await appProgressDialog.stop();
    if (result.isRight()) {
      final notifier = ref.read(visitListProvider.notifier);
      alertMessage(
        errorMessage: S.current.editInvitationSuccessfully,
        context: context,
        statusEnum: AlertStatusEnum.success,
      );
      AppRouter.popUntil(Routes.visitListScreen);

      await notifier.getVisits();
    } else {
      alertMessage(
        errorMessage: result.getLeft().message,
        context: context,
      );
    }
  }

  Future<void> getVisitorHistory() async {
    final visitorHistoryResult =
        await DixelsSDK.instance.visitorService.getPageDataWithEither(
      fromJson: VisitorModel.fromJson,
    );
    if (visitorHistoryResult.isRight()) {
      state = state.copyWith(
        visitorModelList: AsyncData(
          visitorHistoryResult.getRight()?.items ?? [],
        ),
      );
    }
  }

  bool isEdited(VisitModel visitModel) {
    return startDateController.text ==
            visitModel.visitStartDate?.getFormatForDate() &&
        endDateController.text == visitModel.visitEndDate?.getFormatForDate() &&
        startTimeController.text == visitModel.visitStartDate?.getTime() &&
        endTimeController.text == visitModel.visitEndDate?.getTime();
  }

  void _onNameFocus() {
    closeEndDatePickerDialog();
    closeStartDatePickerDialog();
    closeStartTimePickerDialog();
    closeEndTimePickerDialog();
  }
}
