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
            return SizedBox(
              height: 150.h,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    bottom: 0,
                    right: 0,
                    top: 8.h,
                    child: Container(
                      width: double.infinity,
                      height: 140.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.5.r),
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            startColor,
                            endColor,
                          ],
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 16.5.w,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              storeTitle,
                              style: Style.commonTextStyle(
                                color: whiteColor,
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              storeDescription,
                              style: Style.commonTextStyle(
                                color: whiteColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: 5.h),
                            Text(
                              storeStartDay != storeEndDay
                                  ? '$storeStartTime - $storeEndTime $storeStartDay - $storeEndDay'
                                  : '$storeStartTime - $storeEndTime ${S.of(context).today}',
                              style: Style.commonTextStyle(
                                color: whiteColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      right: 0.w,
                    child: Image.network(
                      storeImage.getImageUrl,
                      height: 140.h,
                    ),
                  ),
                ],
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
