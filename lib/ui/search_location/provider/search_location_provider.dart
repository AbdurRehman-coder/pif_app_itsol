import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/ui/search_location/index.dart';

final searchLocationProvider = StateNotifierProvider.autoDispose<SearchLocationNotifier, SearchLocationState>((ref) {
  return SearchLocationNotifier(ref: ref);
});

class SearchLocationNotifier extends StateNotifier<SearchLocationState> {
  SearchLocationNotifier({required this.ref}) : super(SearchLocationState.initial()) {
    _initData();
  }

  final Ref ref;
  final lstSearchLocation = <SearchLocationModel>[];

  void _initData() {
    for (var i = 0; i < 10; i++) {
      lstSearchLocation.add(
        SearchLocationModel(name: 'Al Multaqa 301', roomName: 'First floor - c-suite', isLocationSelected: false),
      );
    }
    state = state.copyWith(lstSearchLocation: lstSearchLocation);
  }

  void updateLocationSelected(int index) {
    lstSearchLocation.where((element) => element.isLocationSelected = false).toList();
    final model = lstSearchLocation.elementAt(index);
    model.isLocationSelected = true;
    state = state.copyWith(lstSearchLocation: lstSearchLocation);
  }
}
