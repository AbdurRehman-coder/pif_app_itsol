import 'package:cached_network_image/cached_network_image.dart';
import 'package:dixels_sdk/features/commerce/rooms/models/room_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pif_flutter/common/extensions/context_extensions.dart';
import 'package:pif_flutter/common/extensions/image_extensions.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/utilities/constant.dart';
import 'package:pif_flutter/routes/routes.dart';
import 'package:pif_flutter/ui/space_booking/extension/amenities_extension.dart';
import 'package:pif_flutter/ui/space_booking/widget/room_description.dart';
import 'package:pif_flutter/widgets/dotindicator.dart';

void roomDetailsPopUp({
  required BuildContext context,
  required RoomModel spaceData,
}) {
  showModalBottomSheet<dynamic>(
    context: context,
    isScrollControlled: true,
    backgroundColor: whiteColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(24.r),
        topRight: Radius.circular(24.r),
      ),
    ),
    builder: (context) {
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

      final controller = PageController();
      final data = getSpaceImages();
      return Padding(
        padding: EdgeInsets.only(right: 16.w, left: 16.w, bottom: 40.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: AppRouter.pop,
              child: Padding(
                padding: EdgeInsets.only(top: 16.h),
                child: Container(
                  height: 5.h,
                  width: 67.w,
                  decoration: BoxDecoration(
                    color: dividerColor,
                    borderRadius: BorderRadius.circular(2.h),
                  ),
                ).toCenter(),
              ),
            ),
            SizedBox(
              height: 24.h,
            ),
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                SizedBox(
                  height: 200.h,
                  child: PageView.builder(
                    controller: controller,
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(16.r),
                        child: CachedNetworkImage(
                          imageUrl: data[index],
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
                if (data.length > 1) ...[
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
                ]
              ],
            ),
            SizedBox(
              height: 8.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    spaceData.name ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Style.commonTextStyle(
                      color: textColor,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(
                  height: 16.h,
                  child: ListView.separated(
                    itemCount: spaceData.amenities!.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        width: 10.w,
                      );
                    },
                    itemBuilder: (context, index) {
                      return SvgPicture.asset(
                        spaceData.amenities![index].key!.getAmenities,
                        height: 16.h,
                        width: 16.w,
                        colorFilter: const ColorFilter.mode(
                          darkBorderColor,
                          BlendMode.srcIn,
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
            SizedBox(
              height: 8.h,
            ),
            RoomDescription(description: spaceData.description ?? ''),
            SizedBox(
              height: 16.h,
            ),
            SizedBox(
              height: 48.h,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          spaceData.rRoomCFloor!.name ?? '',
                          style: Style.commonTextStyle(
                            color: blackColorWith900,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          'Location',
                          style: Style.commonTextStyle(
                            color: blackColorWith900.withOpacity(0.45),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 40.h,
                    width: 1,
                    color: hintColor,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          spaceData.capacity.toString(),
                          style: Style.commonTextStyle(
                            color: blackColorWith900,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          'Seats',
                          style: Style.commonTextStyle(
                            color: blackColorWith900.withOpacity(0.45),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 24.h,
            ),
            ElevatedButton(
              onPressed: () {
                AppRouter.pushNamed(
                  Routes.bookingScreen,
                  args: [spaceData, false, null, false, null],
                );
              },
              style: ElevatedButton.styleFrom(
                fixedSize: Size(context.screenWidth, 48.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.r),
                ),
                textStyle: Style.commonTextStyle(
                  color: whiteColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              child: Text(
                S.of(context).bookNow,
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            ElevatedButton(
              onPressed: () {
                AppRouter.pushNamed(
                  Routes.bookingCalenderScreen,
                  args: [spaceData, true],
                );
              },
              style: ElevatedButton.styleFrom(
                fixedSize: Size(context.screenWidth, 48.h),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.r),
                  side: BorderSide(color: primaryColor, width: 1.w),
                ),
                backgroundColor: whiteColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    Assets.calendar,
                    colorFilter: const ColorFilter.mode(
                      primaryColor,
                      BlendMode.srcIn,
                    ),
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  Text(
                    S.of(context).viewCalender,
                    style: Style.commonTextStyle(
                      color: primaryColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}
