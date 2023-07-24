import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/extensions/context_extensions.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/routes/routes.dart';
import 'package:pif_flutter/ui/company_managment/company_details/provider/company_details_provider.dart';

class CompanyDetailsPage extends ConsumerWidget {
  const CompanyDetailsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(companyDetailsProvider);

    return Scaffold(
      body: Stack(
        children: [
          Column(
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
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                  Positioned(
                    top: 175.h,
                    // Adjust this value to position the image as per your requirement.
                    left: 16.w,
                    child: Container(
                      height: 80.r,
                      width: 80.r,
                      decoration: ShapeDecoration(
                        shape: CircleBorder(
                          side: BorderSide(
                            width: 2.r,
                            color: grayBorderColor,
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
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 16.w,
                    right: 16.w,
                    bottom: 30.h,
                    top: 10.h,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
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
                            'Services',
                            style: Style.commonTextStyle(
                              color: textColor,
                              fontSize: 16.sp,
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
                                padding: EdgeInsets.symmetric(
                                  horizontal: 15.w,
                                  vertical: 10.h,
                                ),
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
                        ListView.separated(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () => AppRouter.pushNamed(
                                Routes.employeeDetailsScreen,
                                args: false,
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    height: 42.h,
                                    width: 42.w,
                                    decoration: ShapeDecoration(
                                      shape: CircleBorder(
                                        side: BorderSide(
                                          width: 2.r,
                                          color: goldenColor,
                                        ),
                                      ),
                                    ),
                                    child: ClipOval(
                                      child: CachedNetworkImage(
                                        height: 42.r,
                                        width: 42.r,
                                        imageUrl: 'https://picsum.photos/50/50',
                                        placeholder: (context, url) =>
                                            const SizedBox(),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16.w,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        provider.lstUser[index].userName ?? '',
                                        style: Style.commonTextStyle(
                                          color: textColor,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Text(
                                        provider.lstUser[index].designation ?? '',
                                        style: Style.commonTextStyle(
                                          color: grayTextColor,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: 24.h,
                            );
                          },
                          itemCount: provider.lstUser.length,
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          InkWell(
            onTap: AppRouter.pop,
            child: Container(
              height: 33.h,
              width: 33.h,
              margin: EdgeInsets.only(top: context.statusBarHeight, left: 20.w),
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: dayTextColor,
                size: 22,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
