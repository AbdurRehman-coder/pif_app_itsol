import 'package:dixels_sdk/common/models/parameters_model.dart';
import 'package:dixels_sdk/dixels_sdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/extensions/date_time_extension.dart';
import 'package:pif_flutter/helpers/filter_utils.dart';
import 'package:pif_flutter/ui/space_booking/index.dart';

final spaceBookingProvider =
    StateNotifierProvider.autoDispose<SpaceBookingNotifier, SpaceBookingState>((ref) {
  return SpaceBookingNotifier(ref: ref);
});

class SpaceBookingNotifier extends StateNotifier<SpaceBookingState> {
  SpaceBookingNotifier({required this.ref}) : super(SpaceBookingState.initial()) {
    _initData();
  }

  final Ref ref;
  List<RoomModel>? bookSearchResult = [];
  late TextEditingController searchController;
  List<RoomModel>? allListData;

  void _initData() {
    searchController = TextEditingController();
  }

  //Get Space Data
  Future<void> getSpaceAsync({bool isFilter = false}) async {
    final data = await DixelsSDK.roomService
        .getPageData(fromJson: RoomModel.fromJson, params: getFilterQuery(isFilter: isFilter));
    if (data != null) {
      allListData = data.items;
      state = state.copyWith(lstData: AsyncData(data.items!));
    }
  }

  // Get Filter Query
  ParametersModel getFilterQuery({required bool isFilter}) {
    final lstQuery = <String>[];
    lstQuery.add(
      FilterUtils.filterBy(
        key: 'bookable',
        value: true.toString(),
        operator: FilterOperator.equal.value,
      ),
    );

    if (isFilter) {
      final filterProvider = ref.read(filterByProvider);
      final filterNotifier = ref.read(filterByProvider.notifier);
      final selectedFloor = filterProvider.lstFloors
          .where((element) => element.isSelected! == true)
          .map((element) => element.id)
          .toList();

      if (filterProvider.selectedDateList.isNotEmpty) {
        // Date Filter Query
      }
      if (filterNotifier.startTimeController.text.isNotEmpty) {
        // StartTime Filter Query
      }
      if (filterNotifier.endTimeController.text.isNotEmpty) {
        // EndTime Filter Query
      }
      if (selectedFloor.isNotEmpty) {
        // for (final item in selectedFloor) {
        //   lstQuery.add(
        //     FilterUtils.filterBy(
        //       key: 'r_room_c_floorId',
        //       value: item.toString(),
        //       operator: FilterOperator.equal.value,
        //     ),
        //   );
        // }
      }
      if (filterProvider.capacity != 1) {
        // lstQuery.add(
        //   FilterUtils.filterBy(
        //     key: 'capacity',
        //     value: filterProvider.capacity.toString(),
        //     operator: FilterOperator.equal.value,
        //   ),
        // );
      }

      final filterModel = FilterModel(
        selectedDates: filterProvider.selectedDateList.toList(),
        startTime: filterProvider.startTime,
        endTime: filterProvider.endTime,
        capacity: filterProvider.capacity.toString(),
        selectedFloorIds: selectedFloor,
      );

      String? timeString = '';
      String? filterString = '';
      if (filterModel.startTime != null && filterModel.endTime != null) {
        final startTimeString = filterModel.startTime?.toFormattedString('hh:mm a');
        final endTimeString = filterModel.endTime?.toFormattedString('hh:mm a');
        timeString = '$startTimeString - $endTimeString - ';
      }

      final firstDateString = filterModel.selectedDates.isNotEmpty
          ? filterModel.selectedDates.first.toFormattedString('d MMM')
          : '';

      if (firstDateString.isNotEmpty) {
        filterString = '$timeString${filterModel.selectedDates.length} repeats from $firstDateString';
      }

      state = state.copyWith(filterData: filterString.isNotEmpty ? filterModel : null);
      state = state.copyWith(filterDataString: filterString);
    }

    final param = ParametersModel();
    param.filterArray = lstQuery;
    return param;
  }

  void onSearch({required String paramSearch}) {
    // bookSearchResult =
    //     state.lstData.value?.where((element) => element.spaceName!.contains(paramSearch)).toList();
    // state = state.copyWith(lstDataSearch: AsyncData(bookSearchResult ?? []));
  }

  //Search Space Data
  void searchData(String searchText) {
    if (allListData == null || (allListData != null && allListData!.isEmpty)) {
      return;
    }
    if (searchText.isNotEmpty) {
      final data = allListData!
          .where((element) => element.name!.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
      state = state.copyWith(lstData: AsyncData(data));
    } else {
      state = state.copyWith(lstData: AsyncData(allListData!));
    }
  }

  void clearFilterData() {
    state = SpaceBookingState.initial();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
