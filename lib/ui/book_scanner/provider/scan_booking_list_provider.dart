import 'package:dixels_sdk/common/models/parameters_model.dart';
import 'package:dixels_sdk/dixels_sdk.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/helpers/filter_utils.dart';
import 'package:pif_flutter/ui/book_scanner/state/scan_booking_list_state.dart';

final scanBookingListProvider =
    StateNotifierProvider<ScanBookingListNotifier, ScanBookingListState>((ref) {
  return ScanBookingListNotifier(ref: ref);
});

class ScanBookingListNotifier extends StateNotifier<ScanBookingListState> {
  ScanBookingListNotifier({required this.ref})
      : super(ScanBookingListState.initial()) {
    _initData();
  }

  final Ref ref;
  late TextEditingController searchController;
  List<RoomModel>? allListData;

  void _initData() {
    searchController = TextEditingController();
    getSpaceAsync();
  }

  //Get Space Data
  Future<void> getSpaceAsync({bool isFilter = false}) async {
    final filterQuery = FilterUtils.filterBy(
      key: 'bookable',
      value: true.toString(),
      operator: FilterOperator.equal.value,
    );

    final param = ParametersModel();
    param.filter = filterQuery;
    param.nestedFields = 'floor,bookings';
    final data = await DixelsSDK.instance.roomService
        .getPageData(fromJson: RoomModel.fromJson, params: param);
    if (data != null) {
      allListData = data.items;
      state = state.copyWith(lstData: AsyncData(data.items!));
    }
  }

  //Search Space Data
  void searchData(String searchText) {
    if (allListData == null || (allListData != null && allListData!.isEmpty)) {
      return;
    }
    if (searchText.isNotEmpty) {
      final data = allListData!
          .where(
            (element) =>
                element.name!.toLowerCase().contains(searchText.toLowerCase()),
          )
          .toList();
      state = state.copyWith(lstData: AsyncData(data));
    } else {
      state = state.copyWith(lstData: AsyncData(allListData!));
    }
  }

  void clearSearchData() {
    searchController.clear();
    state = state.copyWith(lstData: AsyncData(allListData!));
  }

  void setScannedFirstTime(bool value) {
    state = state.copyWith(isScanFirstTime: value);
    AppRouter.pop();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
