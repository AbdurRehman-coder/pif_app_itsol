import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/helpers/assets.dart';
import 'package:pif_flutter/ui/home/provider/home_provider.dart';
import 'package:pif_flutter/ui/home/widget/banner_view.dart';
import 'package:pif_flutter/ui/home/widget/category_list_view.dart';
import 'package:pif_flutter/ui/home/widget/comming_visitor_card.dart';
import 'package:pif_flutter/ui/home/widget/meeting_card.dart';
import 'package:pif_flutter/ui/home/widget/order_status_card.dart';
import 'package:pif_flutter/ui/home/widget/support_status_card.dart';
import 'package:pif_flutter/ui/home/widget/today_status.dart';
import 'package:pif_flutter/utils/colors.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(homeProvider.notifier);
    return Scaffold(
      backgroundColor: lightGrayBgColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 16.h,
          ),
          CarouselSlider(
            options: CarouselOptions(
              height: 140.h,
              autoPlay: true,
              viewportFraction: 1,
            ),
            items: notifier.statusList.map((card) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: card,
              );
            }).toList(),
          ),
          SizedBox(height: 16.h),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 15.w),
              child: const BannerView(),
            ),
          SizedBox(height: 40.h),
           const CategoryListView(),
        ],
      ),
    );
  }
}
