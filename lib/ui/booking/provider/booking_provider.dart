import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pif_flutter/generated/l10n.dart';
import 'package:pif_flutter/helpers/common_utils.dart';
import 'package:pif_flutter/routes/app_router.dart';
import 'package:pif_flutter/ui/booking/model/invite_guest_model.dart';
import 'package:pif_flutter/ui/booking/state/booking_state.dart';
import 'package:pif_flutter/utils/colors.dart';
import 'package:pif_flutter/utils/styles.dart';
import 'package:pif_flutter/widgets/day_calendar_widget/time_planner_date_time.dart';
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

    state = state.copyWith(lstDays: CommonUtils.getNextThirtyDays());
    getTasks();
    getGuestData();
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
  late TextEditingController titleController;
  late TextEditingController dateController;
  late TextEditingController startTimeController;
  late TextEditingController endTimeController;
  late TextEditingController visitorFirstNameController;
  late TextEditingController visitorLastNameController;
  late TextEditingController visitorEmailController;
  late TextEditingController addGuestController;
  late List<TimePlannerTask> lstTasks = [];
  late List<InviteGuestModel> filterAuoCompleteGuestData = [];

  //Update Start Time
  void updateStartTime({required DateTime? startTime}) {
    state = state.copyWith(startTime: startTime);

    final startTimeString = DateFormat('hh:mm a').format(startTime!);
    startTimeController.text = startTimeString;
  }

  //Update End Time
  void updateEndTime({required DateTime? endTime}) {
    if (endTime != null && state.startTime!.isAfter(endTime)) {
      CommonUtils.showToast(message: S.current.timeValidation);
      return;
    }
    state = state.copyWith(endTime: endTime);

    final endTimeString = DateFormat('hh:mm a').format(endTime!);
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
    if (dateList.length == 10) {
      return;
    }
    if (dateList.contains(date)) {
      dateList.remove(date);
    } else {
      dateList.add(date);
    }

    state = state.copyWith(selectedDates: dateList);
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
    getTasks();
  }

  //Search Guest
  void searchGuest(String searchText) {
    state = state.copyWith(isVisibleAddGuestList: searchText.isNotEmpty);
    if (searchText.isNotEmpty) {
      final data = filterAuoCompleteGuestData
          .where((element) => element.fullName!.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
      state = state.copyWith(lstAutoCompleteGuests: data);
    }
  }

  //Book Now Event
  void bookNowAsync() {}

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

  // Get Booking Task Data
  void getTasks() {
    lstTasks.clear();
    final selectedDay = state.lstDays.firstWhere((element) => element.isSelected! == true);
    if (selectedDay.dayDate == DateTime.now().day.toString()) {
      lstTasks.add(
        TimePlannerTask(
          color: primaryColor,
          leftSpace: 40,
          dateTime: TimePlannerDateTime(
            day: DateTime(2023, 5, 11, 22).day,
            hour: DateTime(2023, 5, 11, 22).hour,
            minutes: DateTime(2023, 5, 11, 22).minute,
          ),
          minutesDuration: 60,
          onTap: () {},
          child: Text(
            'Booking for [Fahad O.]',
            style: Style.commonTextStyle(
              color: whiteColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );

      lstTasks.add(
        TimePlannerTask(
          color: primaryColor,
          leftSpace: 40,
          dateTime: TimePlannerDateTime(
            day: DateTime(2023, 5, 11, 2).day,
            hour: DateTime(2023, 5, 11, 2).hour,
            minutes: DateTime(2023, 5, 11, 2).minute,
          ),
          minutesDuration: 30,
          onTap: () {},
          child: Text(
            'Booking for [Fahad O.]',
            style: Style.commonTextStyle(
              color: whiteColor,
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
    } else if (selectedDay.dayDate == DateTime.now().add(const Duration(days: 1)).day.toString()) {
      lstTasks.add(
        TimePlannerTask(
          color: primaryColor,
          leftSpace: 40,
          dateTime: TimePlannerDateTime(
            day: DateTime(2023, 5, 11, 4).day,
            hour: DateTime(2023, 5, 11, 4).hour,
            minutes: DateTime(2023, 5, 11, 4).minute,
          ),
          minutesDuration: 15,
          onTap: () {},
          child: Text(
            'Booking for [Fahad O.]',
            style: Style.commonTextStyle(
              color: whiteColor,
              fontSize: 8.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );

      lstTasks.add(
        TimePlannerTask(
          isBlocked: true,
          color: primaryColor,
          leftSpace: 40,
          dateTime: TimePlannerDateTime(
            day: DateTime(2023, 5, 11, 5).day,
            hour: DateTime(2023, 5, 11, 5).hour,
            minutes: DateTime(2023, 5, 11, 5).minute,
          ),
          minutesDuration: 75,
          onTap: () {},
          child: Text(
            'Booking for [Fahad O.]',
            style: Style.commonTextStyle(
              color: whiteColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
    }
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
    super.dispose();
  }
}
