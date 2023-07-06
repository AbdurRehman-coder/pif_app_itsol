import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:dixels_sdk/dixels_sdk.dart';
import 'package:dixels_sdk/features/commerce/booking/model/booking_model.dart';
import 'package:dixels_sdk/features/commerce/booking/model/booking_request_model.dart';
import 'package:dixels_sdk/features/commerce/visit/models/visit_param.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pif_flutter/common/extensions/date_time_extension.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/message/progress_dialog.dart';
import 'package:pif_flutter/common/shared/message/success_message.dart';
import 'package:pif_flutter/common/shared/message/toast_message.dart';
import 'package:pif_flutter/helpers/common_utils.dart';
import 'package:pif_flutter/routes/routes.dart';
import 'package:pif_flutter/ui/booking/index.dart';
import 'package:pif_flutter/ui/space_booking/provider/space_booking_provider.dart';
import 'package:pif_flutter/widgets/day_calendar_widget/time_planner_task.dart';

final bookingProvider = StateNotifierProvider.autoDispose<BookingNotifier, BookingState>((ref) {
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
    startTimeController = TextEditingController();
    endTimeController = TextEditingController();
    addGuestController = TextEditingController();

    titleFocus = FocusNode();
    addGuestFocus = FocusNode();
    addGuestFocus.addListener(_onTitleFocus);
    titleFocus.addListener(_onTitleFocus);
    formKey = GlobalKey<FormState>();

    state = state.copyWith(lstDays: CommonUtils.getNextThirtyDays());
    getGuestData();
    final currentDateTime = DateTime.now();
    final currentDate = DateTime(currentDateTime.year, currentDateTime.month, currentDateTime.day, 12);
    if (currentDate.weekday != DateTime.friday && currentDate.weekday != DateTime.saturday) {
      updateDateString(currentDate);
      confirmDateLst.addAll(selectedDateLst);
      state = state.copyWith(selectedDates: confirmDateLst);
      formatSelectedDateToString();
    }

    //Bind Filter Data
    final data = ref.read(spaceBookingProvider);
    if (data.filterData != null) {
      updateStartTime(startTime: data.filterData!.startTime);
      updateEndTime(endTime: data.filterData!.endTime);
      state = state.copyWith(selectedDates: data.filterData!.selectedDates);

      selectedDateLst.addAll(data.filterData!.selectedDates);
      confirmDateLst.addAll(data.filterData!.selectedDates);
      formatSelectedDateToString();
    }
  }

  //Set Default Data For Scan
  Future<void> bindScanData() async {
    final userDetails = await DixelsSDK.instance.userDetails;
    titleController.text = S.current.bookingFor + userDetails!.name!;
    final currentDateTime = DateTime.now();
    final currentDate = DateTime(currentDateTime.year, currentDateTime.month, currentDateTime.day, 12);
    state = state.copyWith(selectedDates: [currentDate]);
    formatSelectedDateToString();
    _setNearestTimeSlot();
  }

  // Get Guest Data
  Future<void> getGuestData() async {
    final result = await DixelsSDK.instance.accountService.getUsers();
    if (result != null && result.items!.isNotEmpty) {
      filterAuoCompleteGuestData = result.items!;
    }
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
    startTimeController.text = startTimeString;
  }

  //Update End Time
  void updateEndTime({required DateTime? endTime, BuildContext? context}) {
    if (endTime == null) {
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
  }

  //Open DatePicker Dialog
  void openDatePickerDialog() {
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

    Future.delayed(Duration.zero, () {
      state = state.copyWith(isOpenDatePicker: true);
    });
  }

  //Close DatePicker Dialog
  void closeDatePickerDialog() {
    state = state.copyWith(isOpenDatePicker: false);
  }

  //Open StartTime Picker Dialog
  void openStartTimePickerDialog() {
    if (titleFocus.hasFocus) {
      titleFocus.unfocus();
    }
    if (addGuestFocus.hasFocus) {
      addGuestFocus.unfocus();
    }
    if (state.isOpenDatePicker) {
      closeDatePickerDialog();
    }
    if (state.isOpenEndTimePicker) {
      closeEndTimePickerDialog();
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
    if (state.isOpenDatePicker) {
      closeDatePickerDialog();
    }
    if (state.isOpenStartTimePicker) {
      closeStartTimePickerDialog();
    }

    Future.delayed(Duration.zero, () {
      state = state.copyWith(isOpenEndTimePicker: true);
    });
  }

  //Close StartTime Picker Dialog
  void closeEndTimePickerDialog() {
    state = state.copyWith(isOpenEndTimePicker: false);
  }

  //Update Selected Date Data
  void updateDateString(DateTime date) {
    if (selectedDateLst.contains(date)) {
      selectedDateLst.remove(date);
    } else {
      if (selectedDateLst.length < 10) {
        selectedDateLst.add(date);
      }
    }
  }

  void confirm() {
    confirmDateLst.clear();
    confirmDateLst.addAll(selectedDateLst);
    state = state.copyWith(selectedDates: confirmDateLst);
    formatSelectedDateToString();
  }

  void cancel() {
    state = state.copyWith(selectedDates: confirmDateLst);
    selectedDateLst.clear();
    selectedDateLst.addAll(confirmDateLst);
  }

  //Format Selected Date String
  void formatSelectedDateToString() {
    final dateList = state.selectedDates.toList();
    final dateFormat = DateFormat('d');
    if (dateList.isEmpty) {
      state = state.copyWith(selectedDateString: '');
      dateController.text = state.selectedDateString;
      return;
    }
    final groupedDates = groupBy<DateTime, String>(
      dateList,
      (date) => DateFormat('MMM yyyy').format(date),
    );

    var lastDateString = '';
    groupedDates.forEach((key, value) {
      final dateStrings = value.map(dateFormat.format).join(', ');
      lastDateString = '$lastDateString $dateStrings $key';
    });
    state = state.copyWith(selectedDateString: lastDateString);

    dateController.text = lastDateString;
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
            (element) => element.name!.toLowerCase().contains(searchText.toLowerCase()),
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
      final lstDates = state.selectedDates;
      final startTimeInMinutes = state.startTime!.toTotalMinutes();
      final endTimeInMinutes = state.endTime!.toTotalMinutes();

      if (endTimeInMinutes <= startTimeInMinutes) {
        alertMessage(
          errorMessage: S.current.dateTimeCompareMsg,
          context: context,
        );
        return;
      }

      final currentDateData = lstDates.firstWhereOrNull((element) => element.isSameDate(DateTime.now()));
      if (currentDateData != null) {
        if (state.startTime!.isBefore(DateTime.now())) {
          alertMessage(
            errorMessage: S.current.pastBookingAlert,
            context: context,
          );
          return;
        }
      }

      final data = isSlotAvailable();
      final lstSlotData = data.entries.where((element) => element.value == false).toList();
      final bookingDateAlertMsg =
          data.entries.where((element) => element.value == false).map((e) => e.key.day).toList().join(',');
      if (lstSlotData.isEmpty) {
        await createBooking(
          roomId: roomId,
          startTimeInMinutes: startTimeInMinutes,
          endTimeInMinutes: endTimeInMinutes,
          isBookEnabled: isBookEnabled,
          context: context,
        );
      } else {
        alertMessage(
          errorMessage: '${S.current.bookingAlert} On Date $bookingDateAlertMsg',
          context: context,
        );
      }

      // await checkBookingFound(
      //   roomId: roomId,
      //   startTimeInMinutes: startTimeInMinutes,
      //   endTimeInMinutes: endTimeInMinutes,
      //   isBookEnabled: isBookEnabled,
      //   context: context,
      // );
    }
  }

  Map<DateTime, bool> isSlotAvailable() {
    final result = <DateTime, bool>{};
    final lstDates = state.selectedDates;
    for (final item in lstDates) {
      final data = allBookingTasks.where((element) => element.dateTime.isSameDate(item)).toList();
      var isAvailable = true;
      if (data.isNotEmpty) {
        for (final item in data) {
          final startTime = item.dateTime;
          final endTime = item.dateTime.add(Duration(minutes: item.minutesDuration));

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
          if ((startTime.isBefore(stateEndTime) && endTime.isAfter(stateStartTime)) ||
              (startTime.isAtSameMomentAs(stateStartTime)) ||
              (endTime.isAtSameMomentAs(stateEndTime))) {
            isAvailable = false; // Overlapping slot found, set availability to false
            break; // Exit the loop since availability is already determined
          }
        }
        // Store the availability for the current date
      }
      result[item] = isAvailable;
    }
    return result;
  }

  //Check if we hae a booking in the same time
  // Future<void> checkBookingFound({
  //   required int roomId,
  //   required int startTimeInMinutes,
  //   required int endTimeInMinutes,
  //   required bool isBookEnabled,
  //   required BuildContext context,
  // }) async {
  //   final appProgress = AppProgressDialog(context: context);
  //   await appProgress.start();
  //   final lstDates = state.selectedDates;
  //   final dayListString = lstDates
  //       .map(
  //         (e) => " and contains(bookedDates,'${e.toFormattedString('yyyy-MM-dd')}')",
  //       )
  //       .toList()
  //       .join('');
  //   final param = ParametersModel();
  //
  //   final filterParam = '${FilterUtils.filterBy(
  //     key: 'r_bookings_c_roomId',
  //     value: "'$roomId'",
  //     operator: FilterOperator.equal.value,
  //   )} and ((${FilterUtils.filterBy(
  //     key: 'endTime',
  //     value: '$startTimeInMinutes',
  //     operator: FilterOperator.lessThan.value,
  //   )}) or (${FilterUtils.filterBy(
  //     key: 'startTime',
  //     value: '$endTimeInMinutes',
  //     operator: FilterOperator.greaterThan.value,
  //   )}))$dayListString';
  //
  //   param.filter = filterParam;
  //   final result = await DixelsSDK.instance.bookingService.getPageDataWithEither(
  //     fromJson: BookingModel.fromJson,
  //     params: param,
  //   );
  //   if (result.isRight()) {
  //     if (result.getRight()!.items!.isEmpty) {
  //       await createBooking(
  //         roomId: roomId,
  //         startTimeInMinutes: startTimeInMinutes,
  //         endTimeInMinutes: endTimeInMinutes,
  //         isBookEnabled: isBookEnabled,
  //         context: context,
  //         appProgress: appProgress,
  //       );
  //     } else {
  //       await appProgress.stop();
  //       alertMessage(
  //         errorMessage: S.current.bookingAlert,
  //         context: context,
  //       );
  //     }
  //   } else {
  //     await appProgress.stop();
  //     alertMessage(
  //       errorMessage: result.getLeft().message,
  //       context: context,
  //     );
  //   }
  // }

  //Create booking
  Future<void> createBooking({
    required int roomId,
    required int startTimeInMinutes,
    required int endTimeInMinutes,
    required bool isBookEnabled,
    required BuildContext context,
  }) async {
    final appProgress = AppProgressDialog(context: context);

    final lstDates = state.selectedDates;
    final dayListString = lstDates.map((e) => '\"${e.toFormattedString('yyyy-MM-dd')}\"').toList().join(',');
    final requestModel = BookingRequestModel(
      subject: titleController.text,
      bookedDates: '[$dayListString]',
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
      titleText: isBookEnabled ? S.of(context).requestBookTitle : S.of(context).bookingRoom,
      subTitle: S.of(context).bookedByMistake,
      cancelText: isBookEnabled ? S.of(context).cancelRequest : S.of(context).cancel,
      image: isBookEnabled ? Assets.requestBookingConf : Assets.bookConfirmation,
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

  //Add Guest
  void addGuest(UserModel item, BuildContext context) {
    addGuestController.text = '';
    state = state.copyWith(isVisibleAddGuestList: false);
    final data = state.lstGuests.toList();

    final isDataAvailable = data.firstWhereOrNull((element) => element.emailAddress == item.emailAddress);
    if (isDataAvailable != null) {
      alertMessage(errorMessage: S.current.alreadyAdded, context: context);
      return;
    }
    data.add(item);
    state = state.copyWith(lstGuests: data);
  }

  // Remove Invite Guest Data
  void removeGuest(UserModel item) {
    final data = state.lstGuests.toList();
    data.remove(item);
    state = state.copyWith(lstGuests: data);
  }

  //Filter Task Data
  void filterTaskData() {
    final selectedDay = state.lstDays.firstWhere((element) => element.isSelected! == true);
    final taskData =
        allBookingTasks.where((element) => element.dateTime.day == selectedDay.dateTime!.day).toList();
    state = state.copyWith(lstTasks: taskData);
  }

  // Get Booking Task Data
  Future<void> getBookings({required RoomModel? spaceData}) async {
    if (spaceData != null && spaceData.bookings != null && spaceData.bookings!.isNotEmpty) {
      lstBookings = spaceData.bookings!;
      final userDetails = await DixelsSDK.instance.userDetails;
      for (final mainElement in spaceData.bookings!) {
        final dateList = jsonDecode(mainElement.bookedDates!) as List<dynamic>;
        final duration = mainElement.endTime! - mainElement.startTime!;
        if (dateList.isNotEmpty) {
          for (final element in dateList) {
            final dateString = element as String;
            final taskDate = DateTime.parse(dateString);
            final taskTime = DateTime(taskDate.year).add(Duration(minutes: mainElement.startTime!));
            final bookingDateTime =
                DateTime(taskDate.year, taskDate.month, taskDate.day, taskTime.hour, taskTime.minute);
            allBookingTasks.add(
              TimePlannerTask(
                color: primaryColor,
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
  }

  void _onTitleFocus() {
    closeDatePickerDialog();
    closeStartTimePickerDialog();
    closeEndTimePickerDialog();
  }

// // Clear Data
//   void _clearData() {
//     visitorFirstNameController.text = '';
//     visitorLastNameController.text = '';
//     visitorEmailController.text = '';
//     state = state.copyWith(errorMessage: '');
//   }

  //Get Nearest Time Slot
  void _setNearestTimeSlot() {
    final dateTime = DateTime.now();
    final minute = dateTime.minute;
    final minuteModulo = minute % 15;
    var roundedTime = dateTime.subtract(Duration(minutes: minuteModulo));

    roundedTime =
        DateTime(roundedTime.year, roundedTime.month, roundedTime.day, roundedTime.hour, roundedTime.minute);
    state = state.copyWith(startTime: roundedTime);
    state = state.copyWith(endTime: roundedTime.add(const Duration(minutes: 60)));
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
