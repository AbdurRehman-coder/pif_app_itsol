import 'package:dixels_sdk/features/commerce/booking/model/deliver_space_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'search_location_state.freezed.dart';

@freezed
class SearchLocationState with _$SearchLocationState {
  const factory SearchLocationState({
    required AsyncValue<List<DeliverySpaceModel>> lstSearchLocation,
    required List<String> lstFloor,
    required List<String> lstRoomType,
    required String? selectedFloor,
    required String? selectedSpaceType,
  }) = _SearchLocationState;

  factory SearchLocationState.initial() => const SearchLocationState(
        lstSearchLocation: AsyncLoading(),
        lstFloor: <String>[],
        lstRoomType: <String>[],
        selectedFloor: null,
        selectedSpaceType: null,
      );
}
