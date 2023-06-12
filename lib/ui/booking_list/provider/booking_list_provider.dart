import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/generated/l10n.dart';
import 'package:pif_flutter/ui/booking_list/model/booking_list_model.dart';
import 'package:pif_flutter/ui/booking_list/model/status_model.dart';
import 'package:pif_flutter/ui/booking_list/state/booking_list_state.dart';

final bookingListProvider = StateNotifierProvider.autoDispose<BookingListNotifier, BookingListState>((ref) {
  return BookingListNotifier(ref: ref);
});

class BookingListNotifier extends StateNotifier<BookingListState> {
  BookingListNotifier({required this.ref}) : super(BookingListState.initial()) {
    _initData();
    _getBookings();
  }

  final Ref ref;
  late TextEditingController searchController;
  List<BookingStatusModel> lstStatus = <BookingStatusModel>[];
  List<BookingListModel> allListData = <BookingListModel>[];

  void _initData() {
    searchController = TextEditingController();
    lstStatus.add(BookingStatusModel(name: S.current.pendingStatus, isSelected: true));
    lstStatus.add(BookingStatusModel(name: S.current.upComing, isSelected: false));
    lstStatus.add(BookingStatusModel(name: S.current.history, isSelected: false));
    state = state.copyWith(lstStatus: lstStatus);
  }

  void _getBookings() {
    final lstData = <BookingListModel>[];
    lstData.add(
      BookingListModel(
        status: BookingStatusEnum.pendingApproval,
        spaceName: 'Al Multaqa 301',
        bookingTitle: 'Ahmed Emad Invited you for Idea Generation with Client',
        timeRemaining: '2h 30min left',
        timeString: '5:00 pm - 7:00 pm, 21/3/2023',
        repeatedDates: '6, 7, 8, 11, 12, 13 Dec - 1, 4, 6 Jan ',
      ),
    );
    lstData.add(
      BookingListModel(
        status: BookingStatusEnum.expired,
        spaceName: 'Al Multaqa 301',
        bookingTitle: 'You sent a request for Idea Generation with Client',
        timeRemaining: '2h 30min left',
        timeString: '5:00 pm - 7:00 pm, 21/3/2023',
        repeatedDates: '6, 7, 8, 11, 12, 13 Dec - 1, 4, 6 Jan ',
      ),
    );
    lstData.add(
      BookingListModel(
        status: BookingStatusEnum.active,
        spaceName: 'Al Multaqa 301',
        bookingTitle: 'Idea Generation with Client',
        timeRemaining: '2h 30min left',
        timeString: '5:00 pm - 7:00 pm, 21/3/2023',
        repeatedDates: '6, 7, 8, 11, 12, 13 Dec - 1, 4, 6 Jan ',
      ),
    );
    lstData.add(
      BookingListModel(
        status: BookingStatusEnum.logged,
        spaceName: 'Al Multaqa 301',
        bookingTitle: 'Idea Generation with Client',
        timeRemaining: '2h 30min left',
        timeString: '5:00 pm - 7:00 pm, 21/3/2023',
        repeatedDates: '6, 7, 8, 11, 12, 13 Dec - 1, 4, 6 Jan ',
      ),
    );

    allListData = lstData;
    state = state.copyWith(lstData: AsyncData(lstData));
  }

  void searchData(String searchText) {
    if (allListData.isEmpty) {
      return;
    }
    if (searchText.isNotEmpty) {
      final data = allListData
          .where((element) => element.bookingTitle!.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
      state = state.copyWith(lstData: AsyncData(data));
    } else {
      state = state.copyWith(lstData: AsyncData(allListData));
    }
  }

  void updateStatusList({required int index}) {
    for (final element in state.lstStatus) {
      element.isSelected = false;
    }
    final selectedIem = state.lstStatus[index];
    selectedIem.isSelected = true;
    state = state.copyWith(lstStatus: state.lstStatus);

    // final filterData = allListData
    //     .where((element) => element.status!.getStatusText!.toLowerCase() == selectedIem.name!.toLowerCase())
    //     .toList();
    // state = state.copyWith(lstData: AsyncData(filterData));
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
