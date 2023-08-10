import 'package:collection/collection.dart';
import 'package:dixels_sdk/common/models/parameters_model.dart';
import 'package:dixels_sdk/dixels_sdk.dart';
import 'package:dixels_sdk/features/commerce/booking/model/booking_model.dart';
import 'package:dixels_sdk/features/commerce/booking/model/empty_model.dart';
import 'package:dixels_sdk/features/commerce/support/model/status_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:pif_flutter/common/extensions/date_time_extension.dart';
import 'package:pif_flutter/common/shared/message/progress_dialog.dart';
import 'package:pif_flutter/helpers/filter_utils.dart';
import 'package:pif_flutter/ui/booking_list/state/booking_list_state.dart';

final bookingListProvider = StateNotifierProvider.autoDispose<BookingListNotifier, BookingListState>((ref) {
  return BookingListNotifier(ref: ref);
});

class BookingListNotifier extends StateNotifier<BookingListState> {
  BookingListNotifier({required this.ref}) : super(BookingListState.initial()) {
    _initData();
  }

  final Ref ref;
  late TextEditingController searchController;
  late ScrollController scrollController;
  int? page = 1;
  int? lastPage = 1;
  List<StatusModel> lstStatus = <StatusModel>[];
  List<BookingModel> allListData = <BookingModel>[];

  void _initData() {
    searchController = TextEditingController();
    scrollController = ScrollController();
    scrollController.addListener(loadMore);
  }

  void loadMore() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      state = state.copyWith(isLoading: true);
      final param = ParametersModel();
      if (state.selectedStatus!.key != 'all') {
        param.filter = FilterUtils.filterBy(
          key: 'bookingStatus',
          value: "'${state.selectedStatus!.key}'",
          operator: FilterOperator.equal.value,
        );
      }
      getBookings(param: param);
    }
  }

  Future<void> getStatus() async {
    final result = await DixelsSDK.instance.bookingService.getStatusAsync();
    if (result != null && result.listTypeEntries != null) {
      final lstData = result.listTypeEntries!;
      lstData.insert(0, StatusModel(name: 'All', key: 'all'));
      state = state.copyWith(
        lstStatus: AsyncData(lstData),
        selectedStatus: lstData.first,
      );
      updateStatusList(model: state.selectedStatus!);
    }
  }

  Future<void> getBookings({
    ParametersModel? param,
  }) async {
    if (searchController.text.isEmpty) {
      if (lastPage! < page!) {
        state = state.copyWith(isLoading: false);
        return;
      }
    }

    param ??= ParametersModel();
    param.nestedFields = 'attendees,r_bookings_c_room';
    param.restrictFields = 'actions';
    if (state.selectedStatus?.key != 'all') {
      param.filter = FilterUtils.filterBy(
        key: 'bookingStatus',
        value: "'${state.selectedStatus?.key}'",
        operator: FilterOperator.equal.value,
      );
    }

    param.page = searchController.text.isNotEmpty ? 0.toString() : page.toString();
    final result = await DixelsSDK.instance.bookingService.getPageData(
      fromJson: BookingModel.fromJson,
      params: param,
    );
    if (result != null && result.items != null) {
      lastPage = result.lastPage;
      page = page! + 1;
      final listData = state.lstData.value != null ? state.lstData.value!.toList() : <BookingModel>[];
      listData.addAll(result.items!);
      state = state.copyWith(lstData: AsyncData(listData));
    } else {
      state = state.copyWith(lstData: const AsyncError('', StackTrace.empty));
    }
  }

  void searchData(String searchText) {
    if (searchText.isNotEmpty) {
      state = state.copyWith(lstData: const AsyncLoading());

      final param = ParametersModel();
      param.search = searchText;
      getBookings(param: param);
    } else {
      onFilterData();
    }
  }

  void onFilterData() {
    page = 1;
    state = state.copyWith(lstData: const AsyncLoading());
    final param = ParametersModel();
    if (state.selectedStatus!.key != 'all') {
      param.filter = FilterUtils.filterBy(
        key: 'bookingStatus',
        value: "'${state.selectedStatus!.key}'",
        operator: FilterOperator.equal.value,
      );
    }

    getBookings(param: param);
  }

  Future<void> deleteBooking({required String id}) async {
    final params = ParametersModel();
    params.query = id;
    final result = await DixelsSDK.instance.bookingService.deletePageDataWithEither(
      params: params,
      fromJson: EmptyModel.fromJson,
    );
    if (result.isRight()) {}
  }

  Future<void> onClickDeleteBooking({
    required BookingModel booking,
    required BuildContext context,
  }) async {
    final appProgressDialog = AppProgressDialog(context: context);
    await appProgressDialog.start();
    final params = ParametersModel();
    params.query = booking.id.toString();
    if (booking.attendees!.isNotEmpty) {
      await deleteBookingWithAttendees(booking: booking, context: context);
    } else {
      await deleteBooking(id: booking.id.toString());
    }
    removeBookingItem(booking);
    await appProgressDialog.stop();
  }

  void removeBookingItem(BookingModel item) {
    final lstData = state.lstData.value!.toList();
    lstData.remove(item);
    state = state.copyWith(lstData: AsyncData(lstData));
  }

  Future<void> deleteBookingWithAttendees({
    required BookingModel booking,
    required BuildContext context,
  }) async {
    final params = ParametersModel();
    params.query = booking.id.toString();
    final data = await DixelsSDK.instance.userDetails;
    final result = await DixelsSDK.instance.bookingService.deleteBookingWithAttendees(
      bookingId: booking.id.toString(),
      userId: data!.id ?? 0,
    );
    if (result.isRight()) {
      await deleteBooking(id: data.id.toString());
    }
  }

  String formatTimeString({required BookingModel data}) {
    final currentTime = DateTime.now();

    var startTime = DateTime(
      currentTime.year,
      currentTime.month,
      currentTime.day,
    );
    startTime = startTime.add(Duration(minutes: data.startTime!));
    final startTimeString = startTime.toFormattedString('hh:mm a');

    var endTime = DateTime(
      currentTime.year,
      currentTime.month,
      currentTime.day,
    );
    endTime = endTime.add(Duration(minutes: data.endTime!));
    final endTimeString = endTime.toFormattedString('hh:mm a');

    return '$startTimeString -  $endTimeString';
  }

  String formatLeftTime({required BookingModel data}) {
    final currentTime = DateTime.now();
    var date = data.bookedDates?.split(',').first;
    date = date!.replaceAll('[', '');
    date = date.replaceAll(']', '');
    date = date.replaceAll('"', '');
    final startDate = date.getDateTime;
    final dateTime = startDate.add(Duration(minutes: data.startTime!));

    final leftDuration = dateTime.difference(currentTime);
    final leftTimeString = '${leftDuration.inHours} h ${leftDuration.inMinutes} mins left';

    return leftTimeString;
  }

  String formatDateString({required BookingModel data}) {
    String selectedDates;
    selectedDates = data.bookedDates!.replaceAll('[', '');
    selectedDates = selectedDates.replaceAll(']', '');
    selectedDates = selectedDates.replaceAll('"', '');

    final dateList = selectedDates.split(',').toList();
    final dateFormat = DateFormat('d');

    final convertedDates = dateList.map((e) => e.getDateTime).toList();
    var lastDateString = '';

    final groupedDates = groupBy<DateTime, String>(
      convertedDates,
      (date) => DateFormat('MMM yyyy').format(date),
    );

    groupedDates.forEach((key, value) {
      final dateStrings = value.map(dateFormat.format).join(', ');
      lastDateString = '$lastDateString $dateStrings $key';
    });
    return lastDateString;
  }

  void updateStatusList({required StatusModel model}) {
    state = state.copyWith(
      selectedStatus: model,
    );

    for (final element in state.lstStatus.value!) {
      element.isSelected = state.selectedStatus!.key == element.key;
    }
    state = state.copyWith(lstStatus: state.lstStatus);
    onFilterData();
  }

  bool isEditBooking({required BookingModel data}) {
    final currentTime = DateTime.now();
    var date = data.bookedDates?.split(',').first;
    date = date!.replaceAll('[', '');
    date = date.replaceAll(']', '');
    date = date.replaceAll('"', '');
    final startDate = date.getDateTime;
    final dateTime = startDate.add(Duration(minutes: data.startTime!));

    return dateTime.isAfter(currentTime);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
