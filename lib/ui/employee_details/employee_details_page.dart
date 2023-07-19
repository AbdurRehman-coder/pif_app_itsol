import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/extensions/context_extensions.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/ui/employee_details/index.dart';

class EmployeeDetailsPage extends ConsumerWidget {
  const EmployeeDetailsPage({required this.isFromProfile, super.key});

  final bool isFromProfile;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(employeeDetailsProvider);
    final notifier = ref.read(employeeDetailsProvider.notifier);
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      height: 216.h,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        gradient: RadialGradient(
                          center: Alignment(1, 0.5963),
                          radius: 2.6856,
                          colors: [grayGradientStart, grayGradientEnd],
                        ),
                      ),
                      child: CachedNetworkImage(
                        height: 100.h,
                        width: 100.w,
                        imageUrl: 'https://picsum.photos/100/100',
                        placeholder: (context, url) => const SizedBox(),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      ),
                    ),
                    Positioned(
                      top: 175.h, // Adjust this value to position the image as per your requirement.
                      left: 16.w,
                      child: Container(
                        height: 80.r,
                        width: 80.r,
                        decoration: ShapeDecoration(
                          shape: CircleBorder(
                            side: BorderSide(
                              width: 3.r,
                              color: goldenColor,
                            ),
                          ),
                        ),
                        child: ClipOval(
                          child: CachedNetworkImage(
                            imageUrl: 'https://picsum.photos/50/50',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40.h,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 16.w,
                    right: 16.w,
                    bottom: 30.h,
                    top: 10.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Red Sea Global',
                            style: Style.commonTextStyle(
                              color: textColor,
                              fontSize: 22.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          SvgPicture.asset(
                            Assets.svgInstagram,
                          ),
                          SizedBox(
                            width: 12.w,
                          ),
                          SvgPicture.asset(
                            Assets.svgLinkedIn,
                          ),
                          SizedBox(
                            width: 12.w,
                          ),
                          SvgPicture.asset(
                            Assets.svgWhatsApp,
                          ),
                        ],
                      ),
                      Text(
                        'CFO',
                        style: Style.commonTextStyle(
                          color: primaryColor,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      Text(
                        "Red Sea Global is a PIF-owned developer creating innovative and sustainable projects, including two luxury tourism destinations. They aim to protect and enhance the environment while creating economic opportunities and preserving Saudi Arabia's heritage. Red Sea Global is a PIF-owned developer creating innovative and sustainable projects, including two luxury tourism destinations. They aim to protect and enhance the environment while creating economic opportunities and preserving Saudi Arabia's heritage.",
                        style: Style.commonTextStyle(
                          color: grayTextColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Row(
                            children: [
                              InkWell(
                                onTap: notifier.isGeneralVisible,
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: 5.h),
                                  child: Text(
                                    'General',
                                    style: Style.commonTextStyle(
                                      color: provider.isGeneralVisible ? textColor : grayTextColor,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 30.h,
                              ),
                              InkWell(
                                onTap: notifier.isPreferenceVisible,
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: 5.h),
                                  child: Text(
                                    'Preferences',
                                    style: Style.commonTextStyle(
                                      color: provider.isPreferenceVisible ? textColor : grayTextColor,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            height: 1.h,
                            color: textColor,
                            thickness: 4,
                            endIndent: MediaQuery.of(context).size.width * 0.75,
                          ).visibility(visible: provider.isGeneralVisible),
                          Divider(
                            height: 1.h,
                            color: textColor,
                            thickness: 4,
                            indent: MediaQuery.of(context).size.width * 0.24, // 30% of the screen width
                            endIndent: MediaQuery.of(context).size.width * 0.44,
                          ).visibility(visible: provider.isPreferenceVisible),
                          Divider(
                            height: 1.h,
                            color: grayBorderColor,
                            thickness: 1,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      const GeneralView(),
                      SizedBox(
                        height: 16.h,
                      ),
                      Divider(
                        height: 1.h,
                        color: grayBorderColor,
                        thickness: 1,
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      Text(
                        'Find me at',
                        style: Style.commonTextStyle(
                          color: textColor,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      ListView.separated(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              Container(
                                height: 56.h,
                                width: 56.w,
                                decoration: ShapeDecoration(
                                  shape: CircleBorder(
                                    side: BorderSide(
                                      width: 1.r,
                                      color: borderColor,
                                    ),
                                  ),
                                ),
                                child: ClipOval(
                                  child: CachedNetworkImage(
                                    height: 56.r,
                                    width: 56.r,
                                    imageUrl: 'https://picsum.photos/60/60',
                                    placeholder: (context, url) => const SizedBox(),
                                    errorWidget: (context, url, error) => const Icon(Icons.error),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 16.w,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    provider.lstEmployee[index].address ?? '',
                                    style: Style.commonTextStyle(
                                      color: textColor,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    provider.lstEmployee[index].streetName ?? '',
                                    style: Style.commonTextStyle(
                                      color: grayTextColor,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: 24.h,
                          );
                        },
                        itemCount: provider.lstEmployee.length,
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      Divider(
                        height: 1.h,
                        color: grayBorderColor,
                        thickness: 1,
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Interests',
                          style: Style.commonTextStyle(
                            color: textColor,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      SizedBox(
                        height: 40.h,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.r),
                                color: grayGradientStart,
                              ),
                              child: Text(
                                provider.lstService[index].companyService ?? '',
                                style: Style.commonTextStyle(
                                  color: darkBorderColor,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              width: 16.h,
                            );
                          },
                          itemCount: provider.lstService.length,
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: AppRouter.pop,
                child: Container(
                  height: 33.h,
                  width: 33.h,
                  margin: EdgeInsets.only(top: context.statusBarHeight, left: 20.w),
                  decoration: const BoxDecoration(
                    color: activeBgColor,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    color: dayTextColor,
                    size: 22,
                  ),
                ),
              ),
              InkWell(
                child: Container(
                  height: 33.h,
                  width: 33.h,
                  margin: EdgeInsets.only(top: context.statusBarHeight, right: 20.w),
                  decoration: const BoxDecoration(
                    color: activeBgColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isFromProfile ? Icons.edit : Icons.file_download_outlined,
                    color: dayTextColor,
                    size: 22,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
