import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:dixels_sdk/common/models/parameters_model.dart';
import 'package:dixels_sdk/dixels_sdk.dart';
import 'package:dixels_sdk/features/commerce/booking/model/booking_model.dart';
import 'package:dixels_sdk/features/commerce/booking/model/booking_request_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pif_flutter/common/extensions/date_time_extension.dart';
import 'package:pif_flutter/generated/l10n.dart';
import 'package:pif_flutter/helpers/common_utils.dart';
import 'package:pif_flutter/helpers/filter_utils.dart';
import 'package:pif_flutter/routes/app_router.dart';
import 'package:pif_flutter/ui/booking/index.dart';
import 'package:pif_flutter/ui/space_booking/provider/space_booking_provider.dart';
import 'package:pif_flutter/utils/colors.dart';
import 'package:pif_flutter/utils/styles.dart';
import 'package:pif_flutter/widgets/day_calendar_widget/time_planner_task.dart';

final bookingProvider = StateNotifierProvider.autoDispose<BookingNotifier, BookingState>((ref) {
  return BookingNotifier(ref: ref);
});

class BookingNotifier extends StateNotifier<BookingState> {
  BookingNotifier({required this.ref}) : super(BookingState.initial()) {
    _initData();
  }

  // Init Data
  void _initData() {
    titleController = TextEditingController();
    dateController = TextEditingController();
    startTimeController = TextEditingController();
    endTimeController = TextEditingController();
    visitorFirstNameController = TextEditingController();
    visitorLastNameController = TextEditingController();
    visitorEmailController = TextEditingController();
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
      formatSelectedDateToString();
    }
  }

  void getGuestData() {
    final lstData = <InviteGuestModel>[];
    lstData.add(
      InviteGuestModel(
        firstName: 'Viral',
        lastName: 'Panchal',
        email: 'viral@appswave.io',
      ),
    );
    lstData.add(
      InviteGuestModel(
        firstName: 'Muath',
        lastName: 'Awad',
        email: 'muath@appswave.io',
      ),
    );
    lstData.add(
      InviteGuestModel(
        firstName: 'Muath',
        lastName: 'Awad',
        email: 'muath@appswave.io',
      ),
    );
    lstData.add(
      InviteGuestModel(
        firstName: 'Muath',
        lastName: 'Awad',
        email: 'muath@appswave.io',
      ),
    );
    lstData.add(
      InviteGuestModel(
        firstName: 'Muath',
        lastName: 'Awad',
        email: 'muath@appswave.io',
      ),
    );
    lstData.add(
      InviteGuestModel(
        firstName: 'Muath',
        lastName: 'Awad',
        email: 'muath@appswave.io',
      ),
    );
    lstData.add(
      InviteGuestModel(
        firstName: 'Muath',
        lastName: 'Awad',
        email: 'muath@appswave.io',
      ),
    );
    lstData.add(
      InviteGuestModel(
        firstName: 'Alaa',
        lastName: 'Awad',
        email: 'alaa@appswave.io',
      ),
    );

    filterAuoCompleteGuestData = lstData;
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
  late TextEditingController visitorFirstNameController;
  late TextEditingController visitorLastNameController;
  late TextEditingController visitorEmailController;
  late TextEditingController addGuestController;
  late List<TimePlannerTask> allBookingTasks = [];
  late List<InviteGuestModel> filterAuoCompleteGuestData = [];

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
    if (state.startTime!.isAfter(endTime)) {
      CommonUtils.showToast(message: S.current.timeValidation);
      return;
    }
    state = state.copyWith(endTime: endTime);

    final endTimeString = DateFormat('hh:mm a').format(endTime);
    endTimeController.text = endTimeString;
  }

  //Open DatePicker Dialog
  void openDatePickerDialog() {
    if (state.isOpenStartTimePicker || state.isOpenEndTimePicker) {
      return;
    }
    state = state.copyWith(isOpenDatePicker: true);
  }

  //Close DatePicker Dialog
  void closeDatePickerDialog() {
    state = state.copyWith(isOpenDatePicker: false);
  }

  //Open StartTime Picker Dialog
  void openStartTimePickerDialog() {
    state = state.copyWith(isOpenStartTimePicker: true);
  }

  //Close StartTime Picker Dialog
  void closeStartTimePickerDialog() {
    state = state.copyWith(isOpenStartTimePicker: false);
  }

  //Open EndTime Picker Dialog
  void openEndTimePickerDialog() {
    state = state.copyWith(isOpenEndTimePicker: true);
  }

  //Close StartTime Picker Dialog
  void closeEndTimePickerDialog() {
    state = state.copyWith(isOpenEndTimePicker: false);
  }

  //Update Selected Date Data
  void updateDateString(DateTime date) {
    final dateList = state.selectedDates.toList();
    if (dateList.contains(date)) {
      dateList.remove(date);
    } else {
      if (dateList.length < 10) {
        dateList.add(date);
      }
    }

    state = state.copyWith(selectedDates: dateList);
    formatSelectedDateToString();
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
      (date) => DateFormat('MMM').format(date),
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
            (element) => element.fullName!.toLowerCase().contains(searchText.toLowerCase()),
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
      final dayListString =
          lstDates.map((e) => '\"${e.toFormattedString('yyyy-MM-dd')}\"').toList().join(',');
      final startTimeInMinutes = state.startTime!.toTotalMinutes();
      final endTimeInMinutes = state.endTime!.toTotalMinutes();

      for (final item in lstDates) {
        final data = allBookingTasks.firstWhereOrNull((element) => element.dateTime.isSameDate(item));
        if (data != null) {
          if (startTimeInMinutes + 1 > data.dateTime.toTotalMinutes() &&
              startTimeInMinutes - 1 < data.dateTime.toTotalMinutes()) {
            CommonUtils.showToast(message: S.current.bookingAlert);
            return;
          }
        }
      }

      await DixelsSDK.bookingService
          .postPageData(
        reqModel: BookingRequestModel(
          subject: titleController.text,
          bookedDates: '[$dayListString]',
          startTime: startTimeInMinutes,
          endTime: endTimeInMinutes,
          r_host_userId: 20125,
          r_bookings_c_roomId: roomId,
          attendees: state.lstGuests
              .map(
                (attendees) => Attendee(
                  attendees: [
                    attendees.email ?? '',
                  ],
                ),
              )
              .toList(),
        ),
        fromJson: BookingModel.fromJson,
      )
          .then((value) {
        AppRouter.pop();
        bookingConfirmationPopup(
          context: context,
          isRequestBooking: isBookEnabled,
        );
      });
    }
  }

// Invite Now Event
  void inviteAsync() {
    final firstName = visitorFirstNameController.text.trim();
    final lastName = visitorLastNameController.text.trim();
    final email = visitorEmailController.text.trim();

    String? errorMessage = '';
    if (firstName.isEmpty) {
      errorMessage = S.current.firstNameEmpty;
      return;
    }

    if (lastName.isEmpty) {
      errorMessage = S.current.lastNameEmpty;
      return;
    }

    if (email.isEmpty) {
      errorMessage = S.current.emailEmpty;
      return;
    }

    state = state.copyWith(errorMessage: errorMessage);

    final model = InviteGuestModel(
      firstName: firstName,
      lastName: lastName,
      email: email,
    );
    final data = state.lstGuests.toList();
    data.add(model);
    state = state.copyWith(lstGuests: data);
    clearData();
    AppRouter.pop();
  }

// Clear Data
  void clearData() {
    visitorFirstNameController.text = '';
    visitorLastNameController.text = '';
    visitorEmailController.text = '';
    state = state.copyWith(errorMessage: '');
  }

//Add Guest
  void addGuest(InviteGuestModel item) {
    addGuestController.text = '';
    state = state.copyWith(isVisibleAddGuestList: false);
    final data = state.lstGuests.toList();
    data.add(item);
    state = state.copyWith(lstGuests: data);
  }

// Remove Invite Guest Data
  void removeGuest(InviteGuestModel item) {
    final data = state.lstGuests.toList();
    data.remove(item);
    state = state.copyWith(lstGuests: data);
  }

  void filterTaskData() {
    final selectedDay = state.lstDays.firstWhere((element) => element.isSelected! == true);
    final taskData =
        allBookingTasks.where((element) => element.dateTime.day == selectedDay.dateTime!.day).toList();
    state = state.copyWith(lstTasks: taskData);
  }

  // Get Booking Task Data
  Future<void> getBookings({required int? roomId}) async {
    final params = ParametersModel(
      filterArray: [
        FilterUtils.filterBy(
          key: 'r_bookings_c_roomId',
          value: "'$roomId'",
          operator: FilterOperator.equal.value,
        )
      ],
    );

    final result =
        await DixelsSDK.bookingService.getPageData(fromJson: BookingModel.fromJson, params: params);
    if (result != null && result.items != null) {
      for (final mainElement in result.items!) {
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

  @override
  void dispose() {
    titleController.dispose();
    dateController.dispose();
    startTimeController.dispose();
    endTimeController.dispose();
    visitorFirstNameController.dispose();
    visitorLastNameController.dispose();
    visitorEmailController.dispose();
    titleFocus.dispose();
    titleFocus.removeListener(_onTitleFocus);
    super.dispose();
  }
}
