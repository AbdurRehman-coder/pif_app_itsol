import 'package:dixels_sdk/dixels_sdk.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/ui/space_booking/model/filter_model.dart';

part 'space_booking_state.freezed.dart';

@freezed
class SpaceBookingState with _$SpaceBookingState {
  const factory SpaceBookingState({
    required AsyncValue<List<RoomModel>> lstData,
    required AsyncValue<List<RoomModel>> lstDataSearch,
    FilterModel? filterData,
    String? filterDataString,
  }) = _SpaceBookingState;

  factory SpaceBookingState.initial() => const SpaceBookingState(
        lstData: AsyncLoading(),
        lstDataSearch: AsyncLoading(),
      );
}
