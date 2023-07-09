import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/ui/home/model/banner_model.dart';
import 'package:pif_flutter/ui/home/provider/banner_provider.dart';
import 'package:pif_flutter/ui/home/widget/banner_image_view.dart';
import 'package:pif_flutter/ui/home/widget/banner_text_view.dart';
import 'package:pif_flutter/ui/home/widget/banner_video_view.dart';
import 'package:pif_flutter/widgets/dotindicator.dart';

class BannerView extends ConsumerWidget {
  const BannerView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = PageController();
    final provider = ref.watch(bannerProvider);
    final data = provider.listBannerModel;
    return Container(
      height: 201.h,
      width: 358.w,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(24.r), color: whiteColor),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView.builder(
            controller: controller,
            itemCount: data.length,
            itemBuilder: (context, index) {
              if (data[index].bannerType == BannerEnum.image) {
                return BannerImageView(imageUrl: data[index].image ?? '');
              } else if (data[index].bannerType == BannerEnum.video) {
                return BannerVideoView(videoUrl: data[index].videoUrl ?? '');
              } else {
                return BannerTextView(text: data[index].title ?? '');
              }
            },
          ),
          Positioned(
            bottom: 20.h,
            child: SizedBox(
              child: DotsIndicator(
                selectedColor: primaryColor,
                unselectedColor: grayBorderColor,
                kDotSize: 6,
                controller: controller,
                itemCount: data.length,
                onPageSelected: (int page) {
                  controller.animateToPage(
                    page,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
