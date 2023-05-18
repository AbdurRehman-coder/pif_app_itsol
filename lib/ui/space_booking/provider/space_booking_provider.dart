import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/helpers/assets.dart';
import 'package:pif_flutter/ui/space_booking/model/space_booking_model.dart';
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

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
