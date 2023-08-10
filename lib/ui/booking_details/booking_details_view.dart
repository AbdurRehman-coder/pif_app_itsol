import 'package:cached_network_image/cached_network_image.dart';
import 'package:dixels_sdk/features/commerce/booking/model/booking_model.dart';
import 'package:flutter/material.dart';
import 'package:pif_flutter/common/extensions/context_extensions.dart';
import 'package:pif_flutter/common/extensions/image_extensions.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/widget/custom_app_bar.dart';
import 'package:pif_flutter/common/utilities/constant.dart';
import 'package:pif_flutter/ui/booking_details/widget/room_details.dart';
import 'package:pif_flutter/widgets/dotindicator.dart';

class BookingDetails extends StatelessWidget {
  const BookingDetails({required this.data, super.key});

  final BookingModel data;

  @override
  Widget build(BuildContext context) {
    final controller = PageController();
    final images = getSpaceImages();
    return Scaffold(
      appBar: CustomAppBar(
        title: S.of(context).bookingDetails,
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 12.h,
            ),
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 7.h),
                  height: 200.h,
                  child: PageView.builder(
                    controller: controller,
                    itemCount: images.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(16.r),
                        child: CachedNetworkImage(
                          imageUrl: images[index],
                          fit: BoxFit.cover,
                          height: 200.h,
                          width: context.screenWidth,
                          placeholder: (context, url) => Image.asset(
                            Assets.placeHolder,
                            fit: BoxFit.fill,
                            height: 200.h,
                          ),
                          errorWidget: (context, url, error) => Image.asset(
                            Assets.spaceBg2,
                            fit: BoxFit.fill,
                            height: 200.h,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                if (images.length > 1) ...[
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
                        itemCount: images.length,
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
                ]
              ],
            ),
            RoomDetails(
              item: data,
            ),
          ],
        ),
      ),
    );
  }

  List<String> getSpaceImages() {
    final lstData = <String>[];
    if (data.roomModel != null) {
      final image1 = data.roomModel?.image1;
      final image2 = data.roomModel?.image2;
      final image3 = data.roomModel?.image3;
      if (data.roomModel!.imagePrimary != null) {
        lstData.add(data.roomModel!.imagePrimary!.getImageUrl);
      } else {
        lstData.add('https://picsum.photos/800/800');
      }

      if (image1 != null) {
        if (image1.link != null || image1.link!.href!.isNotEmpty) {
          final endIndex = image1.link!.href!.indexOf(image1.link!.label!);
          if (endIndex != -1) {
            final url = image1.link!.href!.substring(0, endIndex) + image1.link!.label!;
            lstData.add(Constant.imageBaseUrl + url);
          }
        }
      }
      if (image2 != null) {
        if (image2.link != null || image2.link!.href!.isNotEmpty) {
          final endIndex = image2.link!.href!.indexOf(image2.link!.label!);
          if (endIndex != -1) {
            final url = image2.link!.href!.substring(0, endIndex) + image2.link!.label!;
            lstData.add(Constant.imageBaseUrl + url);
          }
        }
      }
      if (image3 != null) {
        if (image3.link != null || image3.link!.href!.isNotEmpty) {
          final endIndex = image3.link!.href!.indexOf(image3.link!.label!);
          if (endIndex != -1) {
            final url = image3.link!.href!.substring(0, endIndex) + image3.link!.label!;
            lstData.add(Constant.imageBaseUrl + url);
          }
        }
      }
    } else {
      return ['https://picsum.photos/800/800'];
    }

    return lstData;
  }
}
