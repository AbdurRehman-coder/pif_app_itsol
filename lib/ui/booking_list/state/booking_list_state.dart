import 'package:dixels_sdk/features/commerce/booking/model/booking_model.dart';
import 'package:dixels_sdk/features/commerce/support/model/status_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'booking_list_state.freezed.dart';

@freezed
class BookingListState with _$BookingListState {
  const factory BookingListState({
    required AsyncValue<List<BookingModel>> lstData,
    required AsyncValue<List<StatusModel>> lstStatus,
    required bool isLoading,
    required StatusModel? selectedStatus,
  }) = _BookingListState;

  factory BookingListState.initial() => const BookingListState(
        lstData: AsyncLoading(),
        lstStatus: AsyncLoading(),
        selectedStatus: null,
        isLoading: false,
      );
}
