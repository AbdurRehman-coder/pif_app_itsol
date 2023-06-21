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
    var filterQuery = FilterUtils.filterBy(
      key: 'bookable',
      value: true.toString(),
      operator: FilterOperator.equal.value,
    );

    if (isFilter) {
      final filterProvider = ref.read(filterByProvider);
      final filterNotifier = ref.read(filterByProvider.notifier);
      final selectedFloor =
          filterProvider.lstFloors.where((element) => element.isSelected ?? false == true).toList();

      if (filterProvider.selectedDateList.isNotEmpty) {
        // Date Filter Query
      }
      if (filterNotifier.startTimeController.text.isNotEmpty) {
        // StartTime Filter Query
        final totalMinutes = filterProvider.startTime?.toTotalMinutes();

        filterQuery = '$filterQuery and ${FilterUtils.filterBy(
          key: 'bookings/startTime',
          value: totalMinutes.toString(),
          operator: FilterOperator.greaterOrEqual.value,
        )}';
      }
      if (filterNotifier.endTimeController.text.isNotEmpty) {
        // EndTime Filter Query
        final totalMinutes = filterProvider.endTime?.toTotalMinutes();

        filterQuery = '$filterQuery and ${FilterUtils.filterBy(
          key: 'bookings/endTime',
          value: totalMinutes.toString(),
          operator: FilterOperator.lessOrEqual.value,
        )}';
      }
      if (selectedFloor.isNotEmpty) {
        for (final item in selectedFloor) {
          final id = item.id;
          filterQuery = '$filterQuery and ${FilterUtils.filterBy(
            key: 'r_room_c_floorId',
            value: "'$id'",
            operator: FilterOperator.equal.value,
          )}';
        }
      }
      if (filterProvider.capacity != 1) {
        filterQuery = '$filterQuery and ${FilterUtils.filterBy(
          key: 'capacity',
          value: filterProvider.capacity.toString(),
          operator: FilterOperator.equal.value,
        )}';
      }

      final filterModel = FilterModel(
        selectedDates: filterProvider.selectedDateList.toList(),
        startTime: filterProvider.startTime,
        endTime: filterProvider.endTime,
        capacity: filterProvider.capacity.toString(),
        selectedFloors: selectedFloor,
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
      } else {
        filterString = selectedFloor.map((e) => e.name).join(' - ');
      }

      state = state.copyWith(
        filterData: filterString.isNotEmpty || filterProvider.capacity > 1 ? filterModel : null,
      );
      state = state.copyWith(filterDataString: filterString);
    }

    final param = ParametersModel();
    param.filter = filterQuery;
    param.nestedFields = 'floor,bookings';
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

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
