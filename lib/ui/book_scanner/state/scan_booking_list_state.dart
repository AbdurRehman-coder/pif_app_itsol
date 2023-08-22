import 'package:dixels_sdk/features/commerce/rooms/models/room_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'scan_booking_list_state.freezed.dart';

@freezed
class ScanBookingListState with _$ScanBookingListState {
  const factory ScanBookingListState({
    required AsyncValue<List<RoomModel>> lstData,
    bool? isScanFirstTime,
  }) = _ScanBookingListState;

  factory ScanBookingListState.initial() => const ScanBookingListState(
        lstData: AsyncLoading(),
        isScanFirstTime: true,
      );
}
