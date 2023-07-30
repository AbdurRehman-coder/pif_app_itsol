import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/extensions/color_extensions.dart';
import 'package:pif_flutter/common/extensions/date_time_extension.dart';
import 'package:pif_flutter/common/extensions/image_extensions.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/ui/drinks/provider/drinks_provider.dart';

class StoreInformation extends StatelessWidget {
  const StoreInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final provider = ref.watch(drinksProvider);
        return provider.structureContent.when(
          error: (Object error, StackTrace stackTrace) {
            return const SizedBox();
          },
          data: (storeInformation) {
            final storeTitle =
                storeInformation.contentFields![0].contentFieldValue!.data ??
                    '';
            final storeDescription =
                storeInformation.contentFields![1].contentFieldValue!.data ??
                    '';
            final storeImage = storeInformation
                    .contentFields![2].contentFieldValue!.image!.contentUrl ??
                '';
            final storeStartTime = storeInformation
                .contentFields![3].contentFieldValue!.data!.getTime;
            final storeStartDay = storeInformation
                .contentFields![3].contentFieldValue!.data!.getDay;
            final storeEndTime = storeInformation
                .contentFields![4].contentFieldValue!.data!.getTime;
            final storeEndDay = storeInformation
                .contentFields![4].contentFieldValue!.data!.getDay;
            final startColor =
                '#${storeInformation.contentFields![6].contentFieldValue!.data!}'
                    .hexToColor;
            final endColor =
                '#${storeInformation.contentFields![5].contentFieldValue!.data!}'
                    .hexToColor;
            return Material(
              elevation: 2,
              borderRadius: BorderRadius.all(
                Radius.circular(18.5.r),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(18.5.r),
                  ),
                  color: whiteColor,
                ),
                width: double.infinity,
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            storeTitle,
                            style: Style.commonTextStyle(
                              color: dayTextColor,
                              fontSize: 22.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            storeDescription,
                            style: Style.commonTextStyle(
                              color: grayTextColor,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            storeStartDay != storeEndDay
                                ? '$storeStartTime - $storeEndTime $storeStartDay - $storeEndDay'
                                : '$storeStartTime - $storeEndTime ${S.of(context).today}',
                            style: Style.commonTextStyle(
                              color: grayTextColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      right: 0.w,
                      bottom: 0,
                      top: 0,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 16.0,
                          right: 16,
                          bottom: 16,
                        ),
                        child: Image.network(
                          storeImage.getImageUrl,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          loading: () {
            return const SizedBox();
          },
        );
      },
    );
  }
}
