import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/widget/banner_video_view.dart';
import 'package:pif_flutter/common/shared/widget/shimmer_wrapper.dart';
import 'package:pif_flutter/common/utilities/constant.dart';
import 'package:pif_flutter/ui/dashboard/provider/dashboard_provider.dart';
import 'package:pif_flutter/ui/home/enum/news_enum.dart';
import 'package:pif_flutter/ui/home/provider/home_provider.dart';
import 'package:pif_flutter/ui/home/widget/banner_image_view.dart';
import 'package:pif_flutter/ui/home/widget/banner_text_view.dart';
import 'package:pif_flutter/widgets/dotindicator.dart';

class BannerView extends ConsumerWidget with RouteAware {
  const BannerView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = PageController();
    final providerHomePage = ref.watch(homeProvider);
    final providerDashboard = ref.watch(dashboardProvider);

    final newsList = providerHomePage.newsList;

    return Container(
      height: 201.h,
      width: 358.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        color: whiteColor,
      ),
      child: newsList.when(
        data: (newsList) {
          return Stack(
            alignment: Alignment.bottomCenter,
            children: [
              PageView.builder(
                controller: controller,
                itemCount: newsList.length,
                itemBuilder: (context, index) {
                  final newsImage = newsList[index]
                      .contentFields
                      ?.where((element) => element.name == 'image')
                      .firstOrNull
                      ?.contentFieldValue
                      ?.image
                      ?.contentUrl;
                  final newsVideo = newsList[index]
                      .contentFields
                      ?.where((element) => element.name == 'video')
                      .firstOrNull
                      ?.contentFieldValue
                      ?.document
                      ?.contentUrl;
                  final newsTitle = newsList[index]
                      .contentFields
                      ?.where((element) => element.name == 'title')
                      .firstOrNull
                      ?.contentFieldValue
                      ?.data;
                  final creator = newsList[index].creator;
                  final type = newsVideo != null
                      ? NewsEnum.video
                      : newsTitle != null
                          ? NewsEnum.text
                          : NewsEnum.image;
                  if (type == NewsEnum.image) {
                    return BannerImageView(
                      imageUrl: Constant.imageBaseUrl + (newsImage ?? '') ?? '',
                    );
                  } else if (type == NewsEnum.video) {
                    return Builder(
                      builder: (context) {
                        return BannerVideoView(
                          videoUrl: Constant.imageBaseUrl + newsVideo! ?? '',
                        );
                      },
                    );
                  } else {
                    return BannerTextView(
                      text: newsTitle ?? '',
                      imageCompany: newsImage,
                      creator: creator!,
                      contentFields: newsList[index].contentFields ?? [],
                      dateCreated:
                          newsList[index].dateCreated ?? DateTime.now(),
                      newsType: newsList[index]
                          .taxonomyCategoryBriefs!
                          .first
                          .taxonomyCategoryName,
                    );
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
                    itemCount: newsList.length,
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
          );
        },
        error: (_, __) {
          return const SizedBox();
        },
        loading: () {
          return ShimmerEffect(
            height: 201.h,
            width: 358.w,
          );
        },
      ),
    );
  }
}
