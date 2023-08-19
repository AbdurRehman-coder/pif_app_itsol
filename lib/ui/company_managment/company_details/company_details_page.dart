import 'package:cached_network_image/cached_network_image.dart';
import 'package:dixels_sdk/features/commerce/company_managment/model/company_management_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/extensions/context_extensions.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/helpers/constants.dart';
import 'package:pif_flutter/ui/company_managment/company_details/widget/resident_list_view.dart';

class CompanyDetailsPage extends ConsumerWidget {
  const CompanyDetailsPage({required this.data, super.key});

  final CompanyManagementModel data;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                      height: 80.h,
                      width: 80.w,
                      imageUrl: '${Constants.baseUrl}${data.logo!.link!.href ?? ''}',
                      placeholder: (context, url) => const SizedBox(),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                  ),
                  Positioned(
                    top: 175.h,
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
                          imageUrl: '${Constants.baseUrl}${data.logo!.link!.href ?? ''}',
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
                            Flexible(
                              child: Text(
                                data.name ?? '',
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: Style.commonTextStyle(
                                  color: textColor,
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            // SizedBox(
                            //   width: 8.w,
                            // ),
                            // SvgPicture.asset(
                            //   Assets.svgInstagram,
                            // ),
                            // SizedBox(
                            //   width: 12.w,
                            // ),
                            // SvgPicture.asset(
                            //   Assets.svgLinkedIn,
                            // ),
                            // SizedBox(
                            //   width: 12.w,
                            // ),
                            // SvgPicture.asset(
                            //   Assets.svgWhatsApp,
                            // ),
                          ],
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            data.description ?? '',
                            style: Style.commonTextStyle(
                              color: grayTextColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ).visibility(
                          visible: data.description != null && data.description!.isNotEmpty,
                        ),
                        SizedBox(
                          height: 16.h,
                        ).visibility(
                          visible: data.tags != null && data.tags!.isNotEmpty,
                        ),
                        Divider(
                          height: 1.h,
                          color: grayBorderColor,
                          thickness: 1,
                        ).visibility(
                          visible: data.tags != null && data.tags!.isNotEmpty,
                        ),
                        SizedBox(
                          height: 16.h,
                        ).visibility(
                          visible: data.tags != null && data.tags!.isNotEmpty,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            S.of(context).services,
                            style: Style.commonTextStyle(
                              color: textColor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ).visibility(
                          visible: data.tags != null && data.tags!.isNotEmpty,
                        ),
                        SizedBox(
                          height: 12.h,
                        ).visibility(
                          visible: data.tags != null && data.tags!.isNotEmpty,
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
                                  color: grayF5,
                                ),
                                child: Text(
                                  data.tags?[index].name ?? '',
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
                            itemCount: data.tags!.length,
                          ),
                        ).visibility(
                          visible: data.tags != null && data.tags!.isNotEmpty,
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        Divider(
                          height: 1.h,
                          color: grayBorderColor,
                          thickness: 1,
                        ).visibility(
                          visible: data.residents != null && data.residents!.isNotEmpty,
                        ),
                        SizedBox(
                          height: 16.h,
                        ).visibility(
                          visible: data.residents != null && data.residents!.isNotEmpty,
                        ),
                        ResidentListView(data: data).visibility(
                          visible: data.residents != null && data.residents!.isNotEmpty,
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
        ],
      ),
    );
  }
}
