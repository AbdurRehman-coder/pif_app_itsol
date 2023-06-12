import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/ui/booking_list/model/booking_list_model.dart';
import 'package:pif_flutter/ui/booking_list/model/status_model.dart';

part 'booking_list_state.freezed.dart';

@freezed
class BookingListState with _$BookingListState {
  const factory BookingListState({
    required AsyncValue<List<BookingListModel>> lstData,
    required List<BookingStatusModel> lstStatus,
  }) = _BookingListState;

  factory BookingListState.initial() => const BookingListState(
        lstData: AsyncLoading(),
        lstStatus: <BookingStatusModel>[],
      );
}
