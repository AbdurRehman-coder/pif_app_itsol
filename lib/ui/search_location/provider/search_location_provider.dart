import 'package:collection/collection.dart';
import 'package:dixels_sdk/dixels_sdk.dart';
import 'package:dixels_sdk/features/commerce/booking/model/deliver_space_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/database/settings.dart';
import 'package:pif_flutter/ui/drinks/provider/drinks_provider.dart';
import 'package:pif_flutter/ui/search_location/index.dart';

final searchLocationProvider = StateNotifierProvider.autoDispose<SearchLocationNotifier, SearchLocationState>((ref) {
  return SearchLocationNotifier(ref: ref);
});

class SearchLocationNotifier extends StateNotifier<SearchLocationState> {
  SearchLocationNotifier({required this.ref}) : super(SearchLocationState.initial()) {
    _initData();
  }

  final Ref ref;
  late TextEditingController searchController;

  List<DeliverySpaceModel> lstSearchLocation = <DeliverySpaceModel>[];
  List<DeliverySpaceModel> lstFilterLocation = <DeliverySpaceModel>[];
  List<String> lstFloors = <String>[];
  List<String> lstRoomType = <String>[];

  void _initData() {
    searchController = TextEditingController();
    updateSelectedFloor(floor: S.current.strAll);
    updateSelectedRoomType(roomType: S.current.strAll);
  }

  // get location data
  Future<void> getLocationData() async {
    final result = await DixelsSDK.instance.bookingService.getDeliveryAddress(
      edgeId: Settings.userLocation?.edgeId ?? '0',
      floorId: Settings.userLocation?.floorId ?? '0',
      xAxis: Settings.userLocation?.xPos ?? '0',
      yAxis: Settings.userLocation?.yPos ?? '0',
    );
    if (result.isRight()) {
      final data = result.getRight()!.items;
      if (data != null && data.isNotEmpty) {
        lstSearchLocation = data;
        state = state.copyWith(lstSearchLocation: AsyncData(data));
        final provider = ref.read(drinksProvider);
        if (provider.deliveryLocation != null) {
          final index = lstSearchLocation.indexWhere((element) => element.id == provider.deliveryLocation!.id);
          updateLocationSelected(index);
        }
      }
    }
  }

  // get floor data and room type data for filter
  void getFilterOptionList() {
    if (lstSearchLocation.isEmpty) {
      return;
    }

    for (final item in lstSearchLocation) {
      if (!lstFloors.contains(item.floor)) {
        if (item.floor != null && item.floor!.isNotEmpty) {
          lstFloors.add(item.floor ?? '');
        }
      }
      if (!lstRoomType.contains(item.spaceType)) {
        if (item.spaceType != null && item.spaceType!.isNotEmpty) {
          lstRoomType.add(item.spaceType!);
        }
      }
    }
    lstFloors.insert(0, S.current.strAll);
    lstRoomType.insert(0, S.current.strAll);
    state = state.copyWith(lstFloor: lstFloors, lstRoomType: lstRoomType);
  }

  // get filter data for floor and room type data
  void filterSpaceData() {
    if (state.selectedFloor != null && state.selectedFloor!.isNotEmpty && state.selectedFloor != S.current.strAll) {
      lstFilterLocation = lstSearchLocation.where((element) => element.floor == state.selectedFloor).toList();
    }

    if (state.selectedSpaceType != null && state.selectedSpaceType!.isNotEmpty && state.selectedSpaceType != S.current.strAll) {
      lstFilterLocation = lstSearchLocation.where((element) => element.spaceType == state.selectedSpaceType).toList();
    } else {
      if (state.selectedFloor != null && state.selectedFloor!.isNotEmpty && state.selectedFloor == S.current.strAll) {
        lstFilterLocation = lstSearchLocation;
      }
    }

    if (state.selectedFloor != null &&
        state.selectedFloor!.isNotEmpty &&
        state.selectedSpaceType != null &&
        state.selectedSpaceType!.isNotEmpty &&
        state.selectedFloor != S.current.strAll &&
        state.selectedSpaceType != S.current.strAll) {
      lstFilterLocation = lstSearchLocation
          .where((element) => element.floor == state.selectedFloor)
          .toList()
          .where((element) => element.spaceType == state.selectedSpaceType)
          .toList();
    } else {
      lstFilterLocation = lstFilterLocation;
    }
    searchController.text = '';
    state = state.copyWith(lstSearchLocation: AsyncData(lstFilterLocation));
  }

  // update selected floor
  void updateSelectedFloor({required String floor}) {
    state = state.copyWith(selectedFloor: floor);
  }

  // update selected room type
  void updateSelectedRoomType({required String roomType}) {
    state = state.copyWith(selectedSpaceType: roomType);
  }

  // get  search data
  void searchData(String searchText) {
    if (lstSearchLocation.isEmpty) {
      return;
    }
    if (searchText.isNotEmpty) {
      if (state.selectedFloor != null || state.selectedSpaceType != null) {
        final data = lstFilterLocation
            .where(
              (element) => element.name!.toLowerCase().contains(
                    searchText.toLowerCase(),
                  ),
            )
            .toList();
        state = state.copyWith(
          lstSearchLocation: AsyncData(data),
        );
      } else {
        final data = lstSearchLocation
            .where(
              (element) => element.name!.toLowerCase().contains(
                    searchText.toLowerCase(),
                  ),
            )
            .toList();
        state = state.copyWith(
          lstSearchLocation: AsyncData(data),
        );
      }
    } else {
      if (state.selectedFloor != null && state.selectedFloor != S.current.strAll ||
          state.selectedSpaceType != null && state.selectedSpaceType != S.current.strAll) {
        state = state.copyWith(lstSearchLocation: AsyncData(lstFilterLocation));
      } else {
        state = state.copyWith(lstSearchLocation: AsyncData(lstSearchLocation));
      }
    }
  }

  void saveAsync() {
    final selectedLocation = state.lstSearchLocation.value!.toList().firstWhereOrNull((x) => x.isSelected == true);
    if (selectedLocation == null) {
      return;
    }
    final notifier = ref.read(drinksProvider.notifier);
    notifier.updateDeliveryLocation(spaceModel: selectedLocation);
    AppRouter.pop();
  }

  void updateLocationSelected(int index) {
    final data = state.lstSearchLocation.value!.toList();
    data.where((element) => element.isSelected = false).toList();
    final model = data.elementAt(index);
    model.isSelected = true;
    state = state.copyWith(lstSearchLocation: AsyncData(data));
  }
}
