import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pif_flutter/helpers/assets.dart';
import 'package:pif_flutter/utils/colors.dart';
import 'package:pif_flutter/widgets/dotindicator.dart';

class SliderImages extends StatelessWidget {
  const SliderImages({super.key});

  static const List<String> images = [
    Assets.hotelRoom,
    Assets.hotelRoom,
    Assets.hotelRoom,
    Assets.hotelRoom,
  ];
  @override
  Widget build(BuildContext context) {
    final controller = PageController();
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        SizedBox(
          height: 200.h,
          child: PageView.builder(
            controller: controller,
            itemCount: images.length,
            itemBuilder: (BuildContext context, int index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: Image.asset(
                  images[index],
                  fit: BoxFit.fill,
                ),
              );
            },
          ),
        ),
        Container(
          height: 20.h,
          width: 60.w,
          margin: EdgeInsets.only(bottom: 10.h),
          child: SizedBox(
            height: 20.h,
            child: DotsIndicator(
              selectedColor: primaryColor,
              kDotSize: 6.r,
              unselectedColor: grayBorderColor,
              controller: controller,
              itemCount: 4,
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
  }
}
