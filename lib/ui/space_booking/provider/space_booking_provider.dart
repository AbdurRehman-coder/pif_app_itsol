import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/helpers/assets.dart';
import 'package:pif_flutter/ui/space_booking/model/space_booking_model.dart';
import 'package:pif_flutter/ui/space_booking/state/space_booking_state.dart';

final spaceBookingProvider =
    StateNotifierProvider.autoDispose<SpaceBookingNotifier, SpaceBookingState>(
        (ref) {
  return SpaceBookingNotifier(ref: ref);
});

class SpaceBookingNotifier extends StateNotifier<SpaceBookingState> {
  SpaceBookingNotifier({required this.ref})
      : super(SpaceBookingState.initial());
  final Ref ref;
  List<SpaceBookingModel>? bookSearchResult = [];

  void getSpaceData() {
    final lstData = <SpaceBookingModel>[];
    lstData.add(
      SpaceBookingModel(
        backImage: Assets.spaceBg1,
        buildingNo: '2',
        floorNo: '2',
        spaceName: 'Tuwaiq',
        availableSheet: '2',
      ),
    );
    lstData.add(
      SpaceBookingModel(
        backImage: Assets.spaceBg2,
        buildingNo: '2',
        floorNo: '1',
        spaceName: 'Mada en Saleh',
        availableSheet: '2',
      ),
    );
    lstData.add(
      SpaceBookingModel(
        backImage: Assets.spaceBg3,
        buildingNo: '2',
        floorNo: '1',
        spaceName: 'Al Multaqa 301',
        availableSheet: '2',
      ),
    );
    lstData.add(
      SpaceBookingModel(
        backImage: Assets.spaceBg3,
        buildingNo: '2',
        floorNo: '1',
        spaceName: 'Al Multaqa 301',
        availableSheet: '2',
      ),
    );
    lstData.add(
      SpaceBookingModel(
        backImage: Assets.spaceBg3,
        buildingNo: '2',
        floorNo: '1',
        spaceName: 'Al Multaqa 301',
        availableSheet: '2',
      ),
    );

    state = state.copyWith(lstData: AsyncData(lstData));
  }

  void onSearch({required String paramSearch}) {
    bookSearchResult = state.lstData.value
        ?.where((element) => element.spaceName!.contains(paramSearch))
        .toList();
    state = state.copyWith(lstDataSearch: AsyncData(bookSearchResult ?? []));
  }
}
