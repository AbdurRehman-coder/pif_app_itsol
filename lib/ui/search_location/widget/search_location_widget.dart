import 'package:cached_network_image/cached_network_image.dart';
import 'package:dixels_sdk/features/commerce/booking/model/deliver_space_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/extensions/image_extensions.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/ui/search_location/provider/search_location_provider.dart';
import 'package:pif_flutter/ui/search_location/states/search_location_state.dart';
import 'package:pif_flutter/ui/search_location/widget/search_location_shimmer_widget.dart';

class SearchLocationListView extends StatelessWidget {
  const SearchLocationListView(this.provider, this.notifier, {super.key});
  final SearchLocationState provider;
  final SearchLocationNotifier notifier;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: provider.lstSearchLocation.when(
        data: (data) {
          if (data.isEmpty) {
            return const SizedBox();
          } else {
            return _setListView(data, provider, notifier);
          }
        },
        error: (error, stackTrace) {
          return const SizedBox();
        },
        loading: () {
          return const SearchLocationShimmerWidget();
        },
      ),
    );
  }

  Widget _setListView(
    List<DeliverySpaceModel> data,
    SearchLocationState provider,
    SearchLocationNotifier notifier,
  ) {
    return ListView.separated(
      padding: EdgeInsets.only(bottom: 20.h),
      itemBuilder: (context, index) {
        final floorString = data[index].floor ?? '';
        final roomTypeString = data[index].roomType ?? '';
        final floorRoomString = '$floorString${roomTypeString.isNotEmpty ? ' - ' : ''}$roomTypeString';
        return InkWell(
          onTap: () {
            notifier.updateLocationSelected(index);
          },
          child: Container(
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
                    imageUrl: data[index].imagePrimary!.getImageUrl,
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
                        data[index].name ?? '',
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
                  data[index].isSelected ? Icons.radio_button_checked_outlined : Icons.radio_button_off,
                  size: 22.sp,
                  color: data[index].isSelected ? primaryColor : grayTextColor,
                )
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(
          height: 8.h,
        );
      },
      itemCount: data.length,
    );
  }
}
