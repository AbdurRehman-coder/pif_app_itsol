import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/ui/home/model/banner_model.dart';
import 'package:pif_flutter/ui/home/states/banner_states.dart';

final bannerProvider = StateNotifierProvider.autoDispose<BannerViewNotifier, BannerStates>((ref) {
  return BannerViewNotifier(ref: ref);
});

class BannerViewNotifier extends StateNotifier<BannerStates> {
  BannerViewNotifier({required this.ref}) : super(BannerStates.initial()) {
    _initData();
  }

  List<BannerModel> lstBanner = <BannerModel>[];
  final Ref ref;

  void _initData() {
    lstBanner.add(
      BannerModel(
        image: 'https://picsum.photos/800/800',
        bannerType: BannerEnum.image,
      ),
    );
    lstBanner.add(
      BannerModel(videoUrl: 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4', bannerType: BannerEnum.video),
    );
    lstBanner.add(
      BannerModel(
        title:
            'The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from "de Finibus Bonorum et Malorum" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.ontrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old.',
        bannerType: BannerEnum.text,
      ),
    );
    state = state.copyWith(listBannerModel: lstBanner);
  }
}
