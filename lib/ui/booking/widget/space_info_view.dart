import 'package:cached_network_image/cached_network_image.dart';
import 'package:dixels_sdk/dixels_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pif_flutter/common/extensions/context_extensions.dart';
import 'package:pif_flutter/common/extensions/image_extensions.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/utilities/constant.dart';
import 'package:pif_flutter/widgets/dotindicator.dart';

class SpaceInfoView extends StatelessWidget {
  const SpaceInfoView({required this.spaceData, super.key});

  final RoomModel spaceData;

  @override
  Widget build(BuildContext context) {
    final controller = PageController();
    final lstSpaceImage = getSpaceImages();
    return SizedBox(
      height: context.topHeaderHeight.h,
      child: Stack(
        children: [
          PageView.builder(
            controller: controller,
            itemCount: lstSpaceImage.length,
            physics: const ClampingScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return SizedBox(
                height: context.topHeaderHeight.h,
                child: Stack(
                  children: [
                    CachedNetworkImage(
                      imageUrl: lstSpaceImage[index],
                      fit: BoxFit.cover,
                      width: context.screenWidth,
                      placeholder: (context, url) => Image.asset(
                        Assets.placeHolder,
                        fit: BoxFit.fill,
                      ),
                      errorWidget: (context, url, error) => Image.asset(
                        Assets.spaceBg2,
                        fit: BoxFit.fill,
                      ),
                    ),
                    SvgPicture.asset(
                      Assets.overlayLayer,
                      width: context.screenWidth,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              );
            },
          ),
          Column(
            children: [
              SizedBox(
                height: context.statusBarHeight.h,
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                spaceData.rRoomCFloor?.name ?? '',
                style: Style.commonTextStyle(
                  color: whiteColor,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                spaceData.name ?? '',
                style: Style.commonTextStyle(
                  color: whiteColor,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    Assets.chair,
                    height: 16.h,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text(
                    '${spaceData.capacity} seats ${spaceData.roomType?.name}',
                    style: Style.commonTextStyle(
                      color: whiteColor,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              if (spaceData.amenities != null) ...[
                SizedBox(
                  height: 30.h,
                  child: ListView.separated(
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(horizontal: 40.w),
                    itemCount: spaceData.amenities!.length,
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        width: 10.w,
                      );
                    },
                    itemBuilder: (context, index) {
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            Assets.videoConf,
                            height: 16.h,
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          Text(
                            spaceData.amenities![index].name ?? '',
                            style: Style.commonTextStyle(
                              color: whiteColor,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          Container(
                            height: 9.h,
                            width: 1.w,
                            color: grayBorderColor,
                          )
                        ],
                      );
                    },
                  ),
                )
              ],
              if (lstSpaceImage.length > 1) ...[
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  height: 20.h,
                  width: 50.w,
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: SizedBox(
                    height: 20.h,
                    child: DotsIndicator(
                      selectedColor: primaryColor,
                      unselectedColor: grayBorderColor,
                      controller: controller,
                      itemCount: lstSpaceImage.length,
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
          InkWell(
            onTap: AppRouter.pop,
            child: Container(
              margin: EdgeInsets.only(top: context.statusBarHeight.h, left: 16.w, right: 16.w),
              height: 40.h,
              width: 40.w,
              decoration: BoxDecoration(
                color: lightGoldenColor,
                borderRadius: BorderRadius.circular(
                  20.r,
                ),
              ),
              child: SvgPicture.asset(
                Assets.back,
                fit: BoxFit.scaleDown,
                colorFilter: const ColorFilter.mode(primaryColor, BlendMode.srcIn),
                height: 5.h,
                width: 5.w,
              ),
            ),
          )
        ],
      ),
    );
  }

  List<String> getSpaceImages() {
    final lstData = <String>[];
    final image1 = spaceData.image1;
    final image2 = spaceData.image2;
    final image3 = spaceData.image3;
    lstData.add(spaceData.imagePrimary!.getImageUrl);
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
    return lstData;
  }
}
