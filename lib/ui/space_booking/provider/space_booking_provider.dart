import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/extensions/date_time_extension.dart';
import 'package:pif_flutter/helpers/assets.dart';
import 'package:pif_flutter/ui/space_booking/model/filter_model.dart';
import 'package:pif_flutter/ui/space_booking/model/space_booking_model.dart';
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
  List<SpaceBookingModel>? bookSearchResult = [];
  late TextEditingController searchController;
  List<SpaceBookingModel>? allListData;

  void _initData() {
    searchController = TextEditingController();
  }

  void getSpaceData() {
    final lstData = <SpaceBookingModel>[];
    lstData.add(
      SpaceBookingModel(
        backImage: Assets.spaceBg1,
        buildingNo: '2',
        floorNo: '2',
        spaceName: 'Tuwaiq',
        availableSheet: '2',
        isRequestToApprove: true,
      ),
    );
    lstData.add(
      SpaceBookingModel(
        backImage: Assets.spaceBg2,
        buildingNo: '2',
        floorNo: '1',
        spaceName: 'Mada en Saleh',
        availableSheet: '2',
        isRequestToApprove: false,
      ),
    );
    lstData.add(
      SpaceBookingModel(
        backImage: Assets.spaceBg3,
        buildingNo: '2',
        floorNo: '1',
        spaceName: 'Al Multaqa 301',
        availableSheet: '2',
        isRequestToApprove: false,
      ),
    );
    lstData.add(
      SpaceBookingModel(
        backImage: Assets.spaceBg3,
        buildingNo: '2',
        floorNo: '1',
        spaceName: 'Al Multaqa 301',
        availableSheet: '2',
        isRequestToApprove: false,
      ),
    );
    lstData.add(
      SpaceBookingModel(
        backImage: Assets.spaceBg3,
        buildingNo: '2',
        floorNo: '1',
        spaceName: 'Al Multaqa 301',
        availableSheet: '2',
        isRequestToApprove: false,
      ),
    );
    allListData = lstData;
    state = state.copyWith(lstData: AsyncData(lstData));
  }

  void onSearch({required String paramSearch}) {
    bookSearchResult =
        state.lstData.value?.where((element) => element.spaceName!.contains(paramSearch)).toList();
    state = state.copyWith(lstDataSearch: AsyncData(bookSearchResult ?? []));
  }

  void searchData(String searchText) {
    if (allListData == null || (allListData != null && allListData!.isEmpty)) {
      return;
    }
    if (searchText.isNotEmpty) {
      final data = allListData!
          .where((element) => element.spaceName!.toLowerCase().contains(searchText.toLowerCase()))
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
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
