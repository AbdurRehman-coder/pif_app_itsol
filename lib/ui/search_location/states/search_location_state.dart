import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pif_flutter/ui/search_location/index.dart';

part 'search_location_state.freezed.dart';

@freezed
class SearchLocationState with _$SearchLocationState {
  const factory SearchLocationState({
    required List<SearchLocationModel> lstSearchLocation,
  }) = _SearchLocationState;

  factory SearchLocationState.initial() => const SearchLocationState(
        lstSearchLocation: <SearchLocationModel>[],
      );
}
