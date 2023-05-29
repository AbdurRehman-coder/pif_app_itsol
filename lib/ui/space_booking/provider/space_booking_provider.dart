import 'package:dixels_sdk/common/models/parameters_model.dart';
import 'package:dixels_sdk/dixels_sdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/extensions/date_time_extension.dart';
import 'package:pif_flutter/helpers/filter_utils.dart';
import 'package:pif_flutter/ui/space_booking/model/filter_model.dart';
import 'package:pif_flutter/ui/space_booking/provider/filter_by_provider.dart';
import 'package:pif_flutter/ui/space_booking/state/space_booking_state.dart';

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

  Future<void> getSpaceData() async {
    // final lstData = <SpaceBookingModel>[];
    // lstData.add(
    //   SpaceBookingModel(
    //     backImage: Assets.spaceBg1,
    //     buildingNo: '2',
    //     floorNo: '2',
    //     spaceName: 'Tuwaiq',
    //     availableSheet: '2',
    //     isRequestToApprove: true,
    //   ),
    // );
    // lstData.add(
    //   SpaceBookingModel(
    //     backImage: Assets.spaceBg2,
    //     buildingNo: '2',
    //     floorNo: '1',
    //     spaceName: 'Mada en Saleh',
    //     availableSheet: '2',
    //     isRequestToApprove: false,
    //   ),
    // );
    // lstData.add(
    //   SpaceBookingModel(
    //     backImage: Assets.spaceBg3,
    //     buildingNo: '2',
    //     floorNo: '1',
    //     spaceName: 'Al Multaqa 301',
    //     availableSheet: '2',
    //     isRequestToApprove: false,
    //   ),
    // );
    // lstData.add(
    //   SpaceBookingModel(
    //     backImage: Assets.spaceBg3,
    //     buildingNo: '2',
    //     floorNo: '1',
    //     spaceName: 'Al Multaqa 301',
    //     availableSheet: '2',
    //     isRequestToApprove: false,
    //   ),
    // );
    // lstData.add(
    //   SpaceBookingModel(
    //     backImage: Assets.spaceBg3,
    //     buildingNo: '2',
    //     floorNo: '1',
    //     spaceName: 'Al Multaqa 301',
    //     availableSheet: '2',
    //     isRequestToApprove: false,
    //   ),
    // );
    // allListData = lstData;
    // state = state.copyWith(lstData: AsyncData(lstData));

    ParametersModel? param;
    if (state.filterData != null) {
      param = ParametersModel();
      param.filterArray = [
        FilterUtils.filterBy(
          key: 'capacity',
          value: state.filterData!.capacity,
          operator: FilterOperator.equal.value,
        )
      ];
    }
    final data = await DixelsSDK.roomService.getPageData(fromJson: RoomModel.fromJson, params: param);
    if (data != null) {
      allListData = data.items;
      state = state.copyWith(lstData: AsyncData(data.items!));
    }
  }

  void onSearch({required String paramSearch}) {
    // bookSearchResult =
    //     state.lstData.value?.where((element) => element.spaceName!.contains(paramSearch)).toList();
    // state = state.copyWith(lstDataSearch: AsyncData(bookSearchResult ?? []));
  }

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

  void updateFilterData() {
    final filterProvider = ref.read(filterByProvider);
    if (filterProvider.selectedDateString.isEmpty) {
      state = state.copyWith(filterDataString: '');
      state = state.copyWith(filterData: null);
      return;
    }
    final filterModel = FilterModel(
      selectedDates: filterProvider.selectedDateList,
      startTime: filterProvider.startTime,
      endTime: filterProvider.endTime,
      capacity: filterProvider.capacity.toString(),
    );

    state = state.copyWith(filterData: filterModel);
    final startTimeString = filterModel.startTime.toFormattedString('hh:mm a');
    final endTimeString = filterModel.endTime.toFormattedString('hh:mm a');
    final firstDateString = filterModel.selectedDates.isNotEmpty
        ? filterModel.selectedDates.first.toFormattedString('d MMM')
        : '';

    var filterString = '$startTimeString - $endTimeString';
    if (firstDateString.isNotEmpty) {
      filterString = '$filterString - ${filterModel.selectedDates.length} repeats from $firstDateString';
    }
    state = state.copyWith(filterDataString: filterString);

    getSpaceData();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
