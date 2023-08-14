import 'package:cached_network_image/cached_network_image.dart';
import 'package:dixels_sdk/dixels_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pif_flutter/common/extensions/context_extensions.dart';
import 'package:pif_flutter/common/extensions/image_extensions.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/widget/shimmer_wrapper.dart';
import 'package:pif_flutter/ui/space_booking/popup/room_details_popup.dart';

class SpaceBookingListTile extends StatelessWidget {
  const SpaceBookingListTile({required this.item, super.key});

  final RoomModel item;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () => roomDetailsPopUp(context: context, spaceData: item),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: CachedNetworkImage(
                  imageUrl: item.imagePrimary!.getImageUrl,
                  fit: BoxFit.cover,
                  height: 168.h,
                  width: context.screenWidth,
                  placeholder: (context, url) => ShimmerEffect(
                    height: 168.h,
                    width: context.screenWidth,
                    borderRadius: BorderRadius.circular(40.r),
                  ),
                  errorWidget: (context, url, error) => Image.asset(
                    Assets.spaceBg2,
                    fit: BoxFit.fill,
                    height: 250.h,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 5.h,
                  ),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(17.r),
                      topRight: Radius.circular(16.r),
                    ),
                  ),
                  child: Text(
                    '${item.capacity} seats',
                    style: TextStyle(
                      color: primaryDarkColor,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 10.w,
                bottom: 10.h,
                child: Container(
                  height: 36.h,
                  width: 99.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(6.r),
                    border: Border.all(
                      color: greenBorderColor,
                    ),
                  ),
                  child: Text(
                    S.of(context).bookNow,
                    style: Style.commonTextStyle(
                      color: whiteColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 8.h,
        ),
        Text(
          item.name ?? '',
          style: Style.commonTextStyle(
            color: textColor,
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        Row(
          children: [
            SvgPicture.asset(
              Assets.locationPin,
              height: 14.h,
              width: 14.w,
            ),
            SizedBox(
              width: 4.w,
            ),
            Text(
              item.rRoomCFloor?.name ?? '',
              textAlign: TextAlign.start,
              style: Style.commonTextStyle(
                color: textColor,
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        )
      ],
    );
  }
}
