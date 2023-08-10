import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:dixels_sdk/common/models/parameters_model.dart';
import 'package:dixels_sdk/dixels_sdk.dart';
import 'package:dixels_sdk/features/commerce/booking/model/booking_model.dart';
import 'package:dixels_sdk/features/commerce/booking/model/booking_request_model.dart';
import 'package:dixels_sdk/features/commerce/visit/models/visit_param.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/message/progress_dialog.dart';
import 'package:pif_flutter/common/shared/message/success_message.dart';
import 'package:pif_flutter/common/shared/message/toast_message.dart';
import 'package:pif_flutter/helpers/common_utils.dart';
import 'package:pif_flutter/helpers/filter_utils.dart';
import 'package:pif_flutter/routes/routes.dart';
import 'package:pif_flutter/ui/booking/index.dart';
import 'package:pif_flutter/ui/space_booking/provider/space_booking_provider.dart';
import 'package:pif_flutter/widgets/day_calendar_widget/time_planner_task.dart';

final bookingProvider =
    StateNotifierProvider.autoDispose<BookingNotifier, BookingState>((ref) {
  return BookingNotifier(ref: ref);
});

class BookingNotifier extends StateNotifier<BookingState> {
  BookingNotifier({required this.ref}) : super(BookingState.initial()) {
    _initData();
  }

  final Ref ref;
  late FocusNode titleFocus;
  late FocusNode addGuestFocus;

  late TextEditingController titleController;

  late GlobalKey<FormState> formKey;
  final controller = ScrollController();
  late TextEditingController dateController;
  late TextEditingController startDateController;
  late TextEditingController endDateController;
  late TextEditingController startTimeController;
  late TextEditingController endTimeController;

  late TextEditingController addGuestController;
  late List<TimePlannerTask> allBookingTasks = [];
  late List<UserModel> filterAuoCompleteGuestData = [];
  List<BookingModel> lstBookings = <BookingModel>[];

  List<DateTime> selectedDateLst = <DateTime>[];
  List<DateTime> confirmDateLst = <DateTime>[];

  // Init Data
  void _initData() {
    titleController = TextEditingController();
    dateController = TextEditingController();
    startDateController = TextEditingController();
    startTimeController = TextEditingController();
    endDateController = TextEditingController();
    endTimeController = TextEditingController();
    addGuestController = TextEditingController();

    titleFocus = FocusNode();
    addGuestFocus = FocusNode();
    addGuestFocus.addListener(_onTitleFocus);
    titleFocus.addListener(_onTitleFocus);
    formKey = GlobalKey<FormState>();

    state = state.copyWith(lstDays: CommonUtils.getNextThirtyDays());
    getGuestData();

    //Bind Filter Data
    final data = ref.read(spaceBookingProvider);
    if (data.filterData != null) {
      updateStartTime(startTime: data.filterData!.startTime);
      updateEndTime(endTime: data.filterData!.endTime);
      state = state.copyWith(selectedDates: data.filterData!.selectedDates);

      selectedDateLst.addAll(data.filterData!.selectedDates);
      confirmDateLst.addAll(data.filterData!.selectedDates);
    }
  }

  //Set Default Data For Scan
  Future<void> bindScanData() async {
    final userDetails = await DixelsSDK.instance.userDetails;
    titleController.text = '${S.current.bookingFor} ${userDetails!.name!}';
    final currentDateTime = DateTime.now();
    final currentDate = DateTime(
      currentDateTime.year,
      currentDateTime.month,
      currentDateTime.day,
      12,
    );
    updateStartDate(currentDate);

    _setNearestTimeSlot();
  }

  //Set Default Data For Edit
  Future<void> bindEditData({required BookingModel spaceData, required BuildContext context}) async {
    state = state.copyWith(isFromEdit: true, bookingModel: spaceData);
    // bind the title
    titleController.text = '${S.current.bookingFor} ${spaceData.subject}';

    //bind the start time
    final currentDateTime = DateTime.now();
    var startTime = DateTime(currentDateTime.year, currentDateTime.month, currentDateTime.day);
    startTime = startTime.add(Duration(minutes: spaceData.startTime!));
    updateStartTime(startTime: startTime);

    //bind thr end time
    var endTime = DateTime(currentDateTime.year, currentDateTime.month, currentDateTime.day);
    endTime = endTime.add(Duration(minutes: spaceData.endTime!));
    updateEndTime(endTime: endTime, context: context);
    var date = spaceData.bookedDates?.split(',').first;
    date = date!.replaceAll('[', '');
    date = date.replaceAll(']', '');
    date = date.replaceAll('"', '');
    final startDate = date.getDateTime;
    updateStartDate(startDate);

    // bind the guest data
    if (spaceData.attendees != null && spaceData.attendees!.isNotEmpty) {
      filterAuoCompleteGuestData = spaceData.attendees!;
      state = state.copyWith(lstAutoCompleteGuests: filterAuoCompleteGuestData, lstGuests: filterAuoCompleteGuestData);
    }
  }

  // Get Guest Data
  Future<void> getGuestData() async {
    final result = await DixelsSDK.instance.accountService.getUsers();
    if (result != null && result.items!.isNotEmpty) {
      filterAuoCompleteGuestData = result.items!;
    }
  }

  //Update Start Date
  void updateStartDate(DateTime date) {
    state = state.copyWith(startDate: date);
    startDateController.text = DateFormat('dd MMM yyyy').format(date);

    state = state.copyWith(endDate: date);
    endDateController.text = DateFormat('dd MMM yyyy').format(date);

    closeStartDatePickerDialog();
    formKey.currentState?.validate();
  }

  //Update End Date
  void updateEndDate(DateTime date) {
    state = state.copyWith(endDate: date);
    endDateController.text = DateFormat('dd MMM yyyy').format(date);

    closeEndDatePicker();
    formKey.currentState?.validate();
  }

  //Update Start Time
  void updateStartTime({required DateTime? startTime}) {
    if (startTime == null) {
      return;
    }
    startTime = DateTime(
      startTime.year,
      startTime.month,
      startTime.day,
      startTime.hour,
      startTime.minute,
    );
    state = state.copyWith(startTime: startTime);

    final startTimeString = DateFormat('hh:mm a').format(startTime);
    if (state.bookingModel == null) {
      updateEndTime(endTime: startTime.add(const Duration(minutes: 15)));
    }
    startTimeController.text = startTimeString;
    formKey.currentState?.validate();
  }

  //Update End Time
  void updateEndTime({required DateTime? endTime, BuildContext? context}) {
    if (endTime == null) {
      return;
    }
    if (state.startTime != null && state.startTime == endTime) {
      return;
    }
    endTime = DateTime(
      endTime.year,
      endTime.month,
      endTime.day,
      endTime.hour,
      endTime.minute,
    );
    if (state.startTime != null && state.startTime!.isAfter(endTime)) {
      alertMessage(
        errorMessage: S.current.timeValidation,
        context: context ?? AppRouter.navigatorKey.currentContext!,
      );

      return;
    }
    state = state.copyWith(endTime: endTime);

    final endTimeString = DateFormat('hh:mm a').format(endTime);
    endTimeController.text = endTimeString;
    formKey.currentState?.validate();
  }

  //Open Start DatePicker Dialog
  void openStartDatePickerDialog() {
    if (titleFocus.hasFocus) {
      titleFocus.unfocus();
    }
    if (addGuestFocus.hasFocus) {
      addGuestFocus.unfocus();
    }
    if (state.isOpenStartTimePicker) {
      closeStartTimePickerDialog();
    }
    if (state.isOpenEndTimePicker) {
      closeEndTimePickerDialog();
    }
    if (state.isOpenEndDatePicker) {
      closeEndDatePicker();
    }

    Future.delayed(Duration.zero, () {
      state = state.copyWith(isOpenStartDatePicker: true);
    });
    Future.delayed(const Duration(seconds: 1), () {
      controller.animateTo(
        controller.position.maxScrollExtent - 230.h,
        duration: const Duration(seconds: 1),
        curve: Curves.easeOut,
      );
    });
  }

  //Close end  DatePicker Dialog
  void closeStartDatePickerDialog() {
    state = state.copyWith(isOpenStartDatePicker: false);
  }

  // open end DatePicker
  void openEndDatePickerDialog() {
    if (titleFocus.hasFocus) {
      titleFocus.unfocus();
    }
    if (addGuestFocus.hasFocus) {
      addGuestFocus.unfocus();
    }
    if (state.isOpenStartDatePicker) {
      closeStartDatePickerDialog();
    }
    if (state.isOpenStartTimePicker) {
      closeStartTimePickerDialog();
    }
    if (state.isOpenEndTimePicker) {
      closeEndTimePickerDialog();
    }

    Future.delayed(Duration.zero, () {
      state = state.copyWith(isOpenEndDatePicker: true);
    });

    /// animate scroll controller to show the date picker
    Future.delayed(const Duration(seconds: 1), () {
      controller.animateTo(
        controller.position.maxScrollExtent - 110.h,
        duration: const Duration(seconds: 1),
        curve: Curves.easeOut,
      );
    });
  }

  void closeEndDatePicker() {
    state = state.copyWith(isOpenEndDatePicker: false);
  }

  //Open StartTime Picker Dialog
  void openStartTimePickerDialog() {
    if (titleFocus.hasFocus) {
      titleFocus.unfocus();
    }
    if (addGuestFocus.hasFocus) {
      addGuestFocus.unfocus();
    }
    if (state.isOpenStartDatePicker) {
      closeStartDatePickerDialog();
    }
    if (state.isOpenEndTimePicker) {
      closeEndTimePickerDialog();
    }
    if (state.isOpenEndDatePicker) {
      closeEndDatePicker();
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
    if (titleFocus.hasFocus) {
      titleFocus.unfocus();
    }
    if (addGuestFocus.hasFocus) {
      addGuestFocus.unfocus();
    }
    if (state.isOpenStartDatePicker) {
      closeStartDatePickerDialog();
    }
    if (state.isOpenStartTimePicker) {
      closeStartTimePickerDialog();
    }

    if (state.isOpenEndDatePicker) {
      closeEndDatePicker();
    }

    Future.delayed(Duration.zero, () {
      state = state.copyWith(isOpenEndTimePicker: true);
    });
    Future.delayed(const Duration(seconds: 1), () {
      controller.animateTo(
        controller.position.maxScrollExtent - 30.h,
        duration: const Duration(seconds: 1),
        curve: Curves.easeOut,
      );
    });
  }

  //Close StartTime Picker Dialog
  void closeEndTimePickerDialog() {
    state = state.copyWith(isOpenEndTimePicker: false);
  }

  //Calendar Days Cell Selection and Update List Data
  void updateDays({required int index}) {
    for (final element in state.lstDays) {
      element.isSelected = false;
    }
    state.lstDays[index].isSelected = true;
    state = state.copyWith(lstDays: state.lstDays);
    filterTaskData();
  }

  //Search Guest
  void searchGuest(String searchText) {
    state = state.copyWith(isVisibleAddGuestList: searchText.isNotEmpty);
    if (searchText.isNotEmpty) {
      final data = filterAuoCompleteGuestData
          .where(
            (element) =>
                element.name!
                    .toLowerCase()
                    .contains(searchText.toLowerCase()) ||
                element.emailAddress!
                    .toLowerCase()
                    .contains(searchText.toLowerCase()),
          )
          .toList();
      state = state.copyWith(lstAutoCompleteGuests: data);
    }
  }

  //Book Now Event
  Future<void> bookNowAsync({
    required BuildContext context,
    required bool isBookEnabled,
    required int roomId,
  }) async {
    if (formKey.currentState!.validate()) {
      // final lstDates = state.selectedDates;
      final startTimeInMinutes = state.startTime!.toTotalMinutes();
      final endTimeInMinutes = state.endTime!.toTotalMinutes();

      if (endTimeInMinutes <= startTimeInMinutes) {
        alertMessage(
          errorMessage: S.current.dateTimeCompareMsg,
          context: context,
        );
        return;
      }

      if (state.startDate.isSameDate(DateTime.now()) &&
          state.startTime!.isBefore(DateTime.now())) {
        alertMessage(
          errorMessage: S.current.pastBookingAlert,
          context: context,
        );
        return;
      }

      if (!isSlotAvailable()) {
        if (state.isFromEdit == true) {
          await editBooking(
            endTimeInMinutes: endTimeInMinutes,
            startTimeInMinutes: startTimeInMinutes,
            roomId: roomId,
            context: context,
          );
        } else {
          await createBooking(
            roomId: roomId,
            startTimeInMinutes: startTimeInMinutes,
            endTimeInMinutes: endTimeInMinutes,
            isBookEnabled: isBookEnabled,
            context: context,
          );
        }
      } else {
        alertMessage(
          errorMessage:
              '${S.current.bookingAlert} On Date ${state.startDate.toFormattedString('dd MMM yyyy')}',
          context: context,
        );
      }
    }
  }

  Future<void> editBooking({
    required int roomId,
    required int startTimeInMinutes,
    required int endTimeInMinutes,
    required BuildContext context,
  }) async {
    final appProgress = AppProgressDialog(context: context);
    final dayString = '\"${state.startDate.toFormattedString('yyyy-MM-dd')}\"';
    final requestModel = BookingRequestModel(
      subject: titleController.text,
      bookedDates: '[$dayString]',
      startTime: startTimeInMinutes,
      endTime: endTimeInMinutes,
      r_bookings_c_roomId: roomId,
      attendees: state.lstGuests
          .map(
            (e) => Visitors(
              givenName: e.givenName ?? '',
              familyName: e.familyName ?? '',
              emailAddress: e.emailAddress ?? '',
              alternateName: e.emailAddress!.substring(0, e.emailAddress!.indexOf('@')),
            ),
          )
          .toList(),
    );

    showSuccessMessage(
      context: context,
      titleText:
          // isBookEnabled ? S.of(context).requestBookTitle :
          S.of(context).bookingRoom,
      subTitle: S.of(context).bookedByMistake,
      cancelText:
          // isBookEnabled ? S.of(context).cancelRequest :
          S.of(context).cancel,
      image:
          // isBookEnabled ? Assets.requestBookingConf :
          Assets.bookConfirmation,
      navigateAfterEndTime: () async {
        Future.delayed(Duration.zero, () async {
          await appProgress.start();
        });
        final param = ParametersModel();
        param.query = '${state.bookingModel?.id!}';
        final result = await DixelsSDK.instance.bookingService.patchPageDataWithEither(
          reqModel: requestModel,
          fromJson: BookingModel.fromJson,
          params: param,
        );

        if (result.isRight()) {
          await appProgress.stop();
          await AppRouter.pop();
          state = state.copyWith(isFromEdit: false);
          final notifier = ref.read(spaceBookingProvider.notifier);
          await notifier.getSpaceAsync();

          if (mounted) {
            alertMessage(
              errorMessage: S.current.bookingSlotSuccess,
              context: context,
              statusEnum: AlertStatusEnum.success,
            );
          }
        } else {
          await appProgress.stop();
          if (mounted) {
            alertMessage(
              errorMessage: S.current.somethingWentWrong,
              context: context,
            );
          }
        }
      },
    );
  }

  bool isSlotAvailable() {
    final data = allBookingTasks
        .where((element) => element.dateTime.isSameDate(state.startDate))
        .toList();
    var isAvailable = false;
    if (data.isNotEmpty) {
      for (final item in data) {
        final startTime = item.dateTime;
        final endTime =
            item.dateTime.add(Duration(minutes: item.minutesDuration));

        final stateStartTime = DateTime(
          startTime.year,
          startTime.month,
          startTime.day,
          state.startTime!.hour,
          state.startTime!.minute,
        );

        final stateEndTime = DateTime(
          startTime.year,
          startTime.month,
          startTime.day,
          state.endTime!.hour,
          state.endTime!.minute,
        );
        if ((startTime.isBefore(stateEndTime) &&
                endTime.isAfter(stateStartTime)) ||
            (startTime.isAtSameMomentAs(stateStartTime)) ||
            (endTime.isAtSameMomentAs(stateEndTime))) {
          isAvailable =
              true; // Overlapping slot found, set availability to false
          break; // Exit the loop since availability is already determined
        }
      }
      // Store the availability for the current date
    }
    return isAvailable;
  }

  Future<void> createBooking({
    required int roomId,
    required int startTimeInMinutes,
    required int endTimeInMinutes,
    required bool isBookEnabled,
    required BuildContext context,
  }) async {
    final appProgress = AppProgressDialog(context: context);

    final dayString = '\"${state.startDate.toFormattedString('yyyy-MM-dd')}\"';
    final requestModel = BookingRequestModel(
      subject: titleController.text,
      bookedDates: '[$dayString]',
      startTime: startTimeInMinutes,
      endTime: endTimeInMinutes,
      r_bookings_c_roomId: roomId,
      attendees: state.lstGuests
          .map(
            (e) => Visitors(
              givenName: e.givenName ?? '',
              familyName: e.familyName ?? '',
              emailAddress: e.emailAddress ?? '',
              alternateName:
                  e.emailAddress!.substring(0, e.emailAddress!.indexOf('@')),
            ),
          )
          .toList(),
    );
    showSuccessMessage(
      context: context,
      titleText: isBookEnabled
          ? S.of(context).requestBookTitle
          : S.of(context).bookingRoom,
      subTitle: S.of(context).bookedByMistake,
      cancelText:
          isBookEnabled ? S.of(context).cancelRequest : S.of(context).cancel,
      image:
          isBookEnabled ? Assets.requestBookingConf : Assets.bookConfirmation,
      navigateAfterEndTime: () async {
        Future.delayed(Duration.zero, () async {
          await appProgress.start();
        });
        final result = await DixelsSDK.instance.bookingService.postPageData(
          reqModel: requestModel,
          fromJson: BookingModel.fromJson,
        );
        if (result != null) {
          final notifier = ref.read(spaceBookingProvider.notifier);
          await notifier.getSpaceAsync();
          await appProgress.stop();
          AppRouter.popUntil(Routes.spaceBookingScreen);
          if (mounted) {
            alertMessage(
              errorMessage: S.current.bookingSlotSuccess,
              context: context,
              statusEnum: AlertStatusEnum.success,
            );
          }
        } else {
          await appProgress.stop();
          if (mounted) {
            alertMessage(
              errorMessage: S.current.somethingWentWrong,
              context: context,
            );
          }
        }
      },
    );
  }

  void updateSelectedGuest({required UserModel model}) {
    final data = state.lstAutoCompleteGuests.toList();
    final item = data.firstWhereOrNull((element) => element.id == model.id);
    if (item != null) {
      item.isSelected = !item.isSelected!;
    }

    state = state.copyWith(lstAutoCompleteGuests: data);
  }

  //Add Guest
  void addGuest() {
    addGuestController.text = '';
    state = state.copyWith(isVisibleAddGuestList: false);
    final data = state.lstAutoCompleteGuests.toList();

    final isDataAvailable =
        data.where((element) => element.isSelected == true).toList();
    isDataAvailable.addAll(state.lstGuests);
    // Check if a selected guest is not already in lstGuests and then add it
    final newGuests = isDataAvailable
        .where((guest) => !state.lstGuests.contains(guest))
        .toList();
    // Combine the new guests with invited guest
    final updatedGuests = [...state.lstGuests, ...newGuests];
    state = state.copyWith(lstGuests: updatedGuests);
  }

  // Remove Invite Guest Data
  void removeGuest(UserModel item) {
    final lst = state.lstAutoCompleteGuests.toList();
    final data = state.lstGuests.toList();
    item.isSelected = !item.isSelected!;
    data.remove(item);

    state = state.copyWith(lstGuests: data, lstAutoCompleteGuests: lst);
  }

  //Filter Task Data
  void filterTaskData() {
    final selectedDay =
        state.lstDays.firstWhere((element) => element.isSelected! == true);
    final taskData = allBookingTasks
        .where((element) => element.dateTime.day == selectedDay.dateTime!.day)
        .toList();
    state = state.copyWith(lstTasks: taskData);
  }

  // Get Booking Task Data
  Future<void> getBookings({required RoomModel? spaceData}) async {
    if (spaceData != null &&
        spaceData.bookings != null &&
        spaceData.bookings!.isNotEmpty) {
      lstBookings = spaceData.bookings!;
      await bindCalendarData(lstBookings);
    } else {
      await getBookingInformation(context: AppRouter.navigatorKey.currentContext!, roomId: spaceData!.id!.toString());
    }
  }

  Future<void> bindCalendarData(List<BookingModel>? data) async {
    final userDetails = await DixelsSDK.instance.userDetails;
    for (final mainElement in data!) {
      final dateList = jsonDecode(mainElement.bookedDates!) as List<dynamic>;
      final duration = mainElement.endTime! - mainElement.startTime!;
      if (dateList.isNotEmpty) {
        for (final element in dateList) {
          final dateString = element as String;
          final taskDate = DateTime.parse(dateString);
          final taskTime = DateTime(taskDate.year).add(Duration(minutes: mainElement.startTime!));
          final bookingDateTime = DateTime(taskDate.year, taskDate.month, taskDate.day, taskTime.hour, taskTime.minute);
          allBookingTasks.add(
            TimePlannerTask(
              color: gradientEnd,
              leftSpace: 40,
              isBlocked: userDetails?.id != mainElement.creator?.id,
              dateTime: bookingDateTime,
              minutesDuration: duration,
              onTap: () {},
              child: Text(
                mainElement.subject ?? '',
                style: Style.commonTextStyle(
                  color: whiteColor,
                  height: 1.3,
                  fontSize: duration <= 30 ? 12.sp : 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        }
      }
    }
    filterTaskData();
  }

  Future<void> getBookingInformation({
    required String roomId,
    required BuildContext context,
  }) async {
    var filterQuery = FilterUtils.filterBy(
      key: 'bookable',
      value: true.toString(),
      operator: FilterOperator.equal.value,
    );
    filterQuery = '$filterQuery and ${FilterUtils.filterBy(
      key: 'id',
      value: "'$roomId'",
      operator: FilterOperator.equal.value,
    )}';
    final param = ParametersModel();
    param.filter = filterQuery;
    param.nestedFields = 'bookings';
    final result = await DixelsSDK.instance.roomService.getPageData(fromJson: RoomModel.fromJson, params: param);

    if (result != null && result.items!.isNotEmpty) {
      await bindCalendarData(result.items![0].bookings);
    }
  }

  void _onTitleFocus() {
    closeStartDatePickerDialog();
    closeEndDatePicker();
    closeStartTimePickerDialog();
    closeEndTimePickerDialog();
  }

  //Get Nearest Time Slot
  void _setNearestTimeSlot() {
    final dateTime = DateTime.now();
    final minute = dateTime.minute;
    final minuteModulo = minute % 15;
    var roundedTime = dateTime.subtract(Duration(minutes: minuteModulo));

    roundedTime = DateTime(
      roundedTime.year,
      roundedTime.month,
      roundedTime.day,
      roundedTime.hour,
      roundedTime.minute,
    );
    state = state.copyWith(startTime: roundedTime);
    state =
        state.copyWith(endTime: roundedTime.add(const Duration(minutes: 60)));
    updateStartTime(startTime: state.startTime);
    updateEndTime(endTime: state.endTime);
  }

  void updateInviteList(List<UserModel> lstData) {
    state = state.copyWith(lstGuests: lstData);
  }

  @override
  void dispose() {
    titleController.dispose();
    dateController.dispose();
    startTimeController.dispose();
    endTimeController.dispose();
    titleFocus.dispose();
    titleFocus.removeListener(_onTitleFocus);
    super.dispose();
  }
}
