import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/helpers/assets.dart';
import 'package:pif_flutter/ui/home/model/category_model.dart';
import 'package:pif_flutter/ui/home/states/home_states.dart';

final homeProvider = StateNotifierProvider<HomeNotifier, HomeStates>((ref) {
  return HomeNotifier(ref: ref);
});

class HomeNotifier extends StateNotifier<HomeStates> {
  HomeNotifier({required this.ref}) : super(HomeStates.initial()) {
    _initData();
  }

  final Ref ref;
  List<CategoryModel> lstCategory = <CategoryModel>[];

  void _initData() {
    lstCategory.add(CategoryModel(image: Assets.qrView, text: 'QR Scan'));
    lstCategory.add(CategoryModel(image: Assets.creative, text: 'Creatives'));
    lstCategory.add(CategoryModel(image: Assets.visitor, text: 'Visitors'));
    lstCategory.add(CategoryModel(image: Assets.qrView, text: 'QR Scan'));
    lstCategory.add(CategoryModel(image: Assets.creative, text: 'Creatives'));
    lstCategory.add(CategoryModel(image: Assets.qrView, text: 'QR Scan'));
    lstCategory.add(CategoryModel(image: Assets.visitor, text: 'Visitors'));
    lstCategory.add(CategoryModel(image: Assets.qrView, text: 'QR Scan'));

    state = state.copyWith(lstCategory: lstCategory);
  }
}
