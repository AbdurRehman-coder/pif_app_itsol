import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/ui/home/provider/home_provider.dart';
import 'package:pif_flutter/ui/home/widget/banner_view.dart';
import 'package:pif_flutter/ui/home/widget/cards_shimmer.dart';
import 'package:pif_flutter/ui/home/widget/category_list_view.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({required this.animationController, super.key});

  final AnimationController animationController;

  @override
  ConsumerState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(homeProvider.notifier);
    final provider = ref.watch(homeProvider);
    return Scaffold(
      backgroundColor: lightGrayBgColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 16.h),
            provider.cardList.when(
              data: (data) {
                return CarouselSlider(
                  options: CarouselOptions(
                    height: 120.h,
                    autoPlay: true,
                    viewportFraction: 1,
                  ),
                  items: data.map((card) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: card,
                    );
                  }).toList(),
                );
              },
              error: (_, __) {
                return const SizedBox();
              },
              loading: () {
                return const CardsShimmers();
              },
            ),
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: const BannerView(),
            ),
            SizedBox(height: 40.h),
            CategoryListView(
              animationController: widget.animationController,
            ),
          ],
        ),
      ),
    );
  }
}
