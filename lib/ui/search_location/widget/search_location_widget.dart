import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/ui/search_location/provider/search_location_provider.dart';

class SearchLocationListView extends ConsumerWidget {
  const SearchLocationListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(searchLocationProvider);
    final notifier = ref.read(searchLocationProvider.notifier);
    return Expanded(
      child: ListView.separated(
        padding: EdgeInsets.only(bottom: 20.h),
        itemBuilder: (context, index) {
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
                      fit: BoxFit.fill,
                      imageUrl: 'https://picsum.photos/40/40',
                      placeholder: (context, url) => const SizedBox(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
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
                          provider.lstSearchLocation[index].name ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Style.commonTextStyle(
                            color: pendingStatusColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          provider.lstSearchLocation[index].roomName ?? '',
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
                    provider.lstSearchLocation[index].isLocationSelected!
                        ? Icons.radio_button_checked_outlined
                        : Icons.radio_button_off,
                    size: 22.sp,
                    color: provider.lstSearchLocation[index].isLocationSelected!
                        ? primaryColor
                        : grayTextColor,
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
        itemCount: provider.lstSearchLocation.length,
      ),
    );
  }
}
