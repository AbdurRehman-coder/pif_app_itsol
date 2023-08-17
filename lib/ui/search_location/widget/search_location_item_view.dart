import 'package:cached_network_image/cached_network_image.dart';
import 'package:dixels_sdk/features/commerce/booking/model/deliver_space_model.dart';
import 'package:flutter/material.dart';
import 'package:pif_flutter/common/extensions/image_extensions.dart';
import 'package:pif_flutter/common/index.dart';

class SearchLocationItemView extends StatelessWidget {
  const SearchLocationItemView({required this.data, super.key});
  final DeliverySpaceModel data;
  @override
  Widget build(BuildContext context) {
    final floorString = data.floor ?? '';
    final roomTypeString = data.roomType ?? '';
    final floorRoomString = '$floorString${roomTypeString.isNotEmpty ? ' - ' : ''}$roomTypeString';

    return Container(
      height: 62.h,
      padding: EdgeInsets.all(8.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6.r),
        boxShadow: [
          BoxShadow(
            color: textColor.withOpacity(0.10),
            offset: const Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: Row(
        children: [
          ClipOval(
            child: CachedNetworkImage(
              imageUrl: data.imagePrimary!.getImageUrl,
              fit: BoxFit.cover,
              height: 40.h,
              width: 40.w,
              placeholder: (context, url) => Image.asset(
                Assets.placeHolder,
                fit: BoxFit.fill,
              ),
              errorWidget: (context, url, error) => Image.asset(
                Assets.spaceBg2,
                fit: BoxFit.fill,
              ),
            ),
          ),
          SizedBox(
            width: 16.w,
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.name ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Style.commonTextStyle(
                    color: pendingStatusColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  floorRoomString,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Style.commonTextStyle(
                    color: silverTextColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
          ),
          Icon(
            data.isSelected ? Icons.radio_button_checked_outlined : Icons.radio_button_off,
            size: 22.sp,
            color: data.isSelected ? primaryColor : grayTextColor,
          )
        ],
      ),
    );
  }
}
