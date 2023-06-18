import 'package:cached_network_image/cached_network_image.dart';
import 'package:dixels_sdk/dixels_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pif_flutter/common/extensions/context_extensions.dart';
import 'package:pif_flutter/common/extensions/image_extensions.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/routes/routes.dart';

class SpaceBookingListTile extends StatelessWidget {
  const SpaceBookingListTile({required this.item, super.key});

  final RoomModel item;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: CachedNetworkImage(
            imageUrl: item.imagePrimary!.getImageUrl,
            fit: BoxFit.cover,
            height: 250.h,
            width: context.screenWidth,
            placeholder: (context, url) => Image.asset(
              Assets.placeHolder,
              fit: BoxFit.fill,
              height: 250.h,
            ),
            errorWidget: (context, url, error) => Image.asset(
              Assets.spaceBg2,
              fit: BoxFit.fill,
              height: 250.h,
            ),
          ),
        ),
        SvgPicture.asset(
          Assets.overlayLayer,
          height: 250.h,
          fit: BoxFit.fill,
        ),
        Container(
          height: 250.h,
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 16.h,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Building 2  -  Floor 1',
                style: Style.commonTextStyle(
                  color: whiteColor,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 24.h,
              ),
              Text(
                item.name ?? '',
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
                children: [
                  SvgPicture.asset(
                    Assets.chair,
                    height: 16.h,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text(
                    '${item.capacity} seats ${item.roomType?.name}',
                    style: Style.commonTextStyle(
                      color: whiteColor,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 28.h,
              ),
              if (item.amenities != null) ...[
                SizedBox(
                  height: 40.h,
                  child: ListView.separated(
                    itemCount: item.amenities!.length,
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
                            item.amenities![index].name ?? '',
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
              SizedBox(
                height: 5.h,
              ),
              ElevatedButton(
                onPressed: () {
                  AppRouter.pushNamed(Routes.bookingScreen, args: item);
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(context.screenWidth.w, 35.h),
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.r), // <-- Radius
                  ),
                ),
                child: Text(
                  S.current.book,
                  style: Style.commonTextStyle(
                    color: whiteColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
