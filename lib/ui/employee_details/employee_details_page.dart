import 'package:cached_network_image/cached_network_image.dart';
import 'package:dixels_sdk/dixels_sdk.dart';
import 'package:dixels_sdk/features/commerce/company_managment/model/company_management_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/extensions/context_extensions.dart';
import 'package:pif_flutter/common/extensions/image_extensions.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/helpers/constants.dart';
import 'package:pif_flutter/routes/routes.dart';
import 'package:pif_flutter/ui/employee_details/index.dart';

class EmployeeDetailsPage extends ConsumerStatefulWidget {
  const EmployeeDetailsPage({
    required this.isFromProfile,
    required this.data,
    required this.companyManagementModel,
    super.key,
  });

  final bool isFromProfile;
  final UserModel data;
  final CompanyManagementModel? companyManagementModel;

  @override
  ConsumerState createState() => _EmployeeDetailsPageState();
}

class _EmployeeDetailsPageState extends ConsumerState<EmployeeDetailsPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      ref.read(employeeDetailsProvider.notifier).getSpaceAsync(
            widget.data,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(employeeDetailsProvider);
    final notifier = ref.read(employeeDetailsProvider.notifier);

    final isVIP = widget.data.customFields != null
        ? widget.data.customFields!.firstWhere((element) => element.name == 'Is VIP').customValue.data.toString()
        : '';
    final bio =
        widget.data.customFields != null ? widget.data.customFields!.firstWhere((element) => element.name == 'Bio').customValue.data.toString() : '';
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
                      imageUrl: '${Constants.baseUrl}${widget.companyManagementModel?.logo!.link!.href ?? ''}',
                      placeholder: (context, url) => Image.asset(
                        Assets.placeHolder,
                        fit: BoxFit.fill,
                        height: 80.h,
                        width: 80.w,
                      ),
                      errorWidget: (context, url, error) => Image.network(
                        'https://picsum.photos/80/80',
                        fit: BoxFit.fill,
                        height: 80.h,
                        width: 80.w,
                      ),
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
                            width: isVIP == 'true' ? 3.r : 1.r,
                            color: goldenColor,
                          ),
                        ),
                      ),
                      child: ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: widget.data.image != null && widget.data.image!.isNotEmpty ? widget.data.image!.getImageUrl : '',
                          fit: BoxFit.contain,
                          placeholder: (context, url) => Image.asset(
                            Assets.placeHolder,
                            fit: BoxFit.fill,
                            height: 42.r,
                            width: 42.r,
                          ),
                          errorWidget: (context, url, error) => Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: RegExp(r'^[A-E_.]+$').hasMatch(
                                widget.data.givenName![0].toUpperCase(),
                              )
                                  ? primary800
                                  : RegExp(r'^[J-M_.]+$').hasMatch(
                                      widget.data.givenName![0].toUpperCase(),
                                    )
                                      ? blue400
                                      : RegExp(r'^[N-S_.]+$').hasMatch(
                                          widget.data.givenName![0].toUpperCase(),
                                        )
                                          ? pink200
                                          : primary300,
                            ),
                            child: Text(
                              ' ${widget.data.givenName![0]}${widget.data.familyName![0]}'.toUpperCase(),
                              textAlign: TextAlign.center,
                              style: Style.commonTextStyle(
                                color: whiteColor,
                                fontSize: 28.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                widget.data.name ?? '',
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
                        Text(
                          widget.data.jobTitle ?? '',
                          style: Style.commonTextStyle(
                            color: primaryColor,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            bio,
                            style: Style.commonTextStyle(
                              color: grayTextColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ).visibility(visible: bio.isNotEmpty),
                        SizedBox(
                          height: 16.h,
                        ).visibility(visible: bio.isNotEmpty),
                        Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Row(
                              children: [
                                InkWell(
                                  // onTap: notifier.isGeneralVisible,
                                  child: Padding(
                                    padding: EdgeInsets.only(bottom: 5.h),
                                    child: Text(
                                      S.of(context).general,
                                      style: Style.commonTextStyle(
                                        color: provider.isGeneralVisible ? textColor : grayTextColor,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                                // SizedBox(
                                //   width: 30.h,
                                // ),
                                // InkWell(
                                //   onTap: notifier.isPreferenceVisible,
                                //   child: Padding(
                                //     padding: EdgeInsets.only(bottom: 5.h),
                                //     child: Text(
                                //       S.of(context).preferences,
                                //       style: Style.commonTextStyle(
                                //         color: provider.isPreferenceVisible ? textColor : grayTextColor,
                                //         fontSize: 16.sp,
                                //         fontWeight: FontWeight.w400,
                                //       ),
                                //     ),
                                //   ),
                                // ),
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
                              indent: MediaQuery.of(context).size.width * 0.24,
                              // 30% of the screen width
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
                        GeneralView(data: widget.data),
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
                          S.current.findMeAt,
                          style: Style.commonTextStyle(
                            color: textColor,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ).visibility(visible: provider.spaceName != null && provider.spaceName!.isNotEmpty),
                        SizedBox(
                          height: 8.h,
                        ),
                        Row(
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
                                  imageUrl: provider.spaceImage ?? '',
                                  placeholder: (context, url) => Image.asset(
                                    Assets.placeHolder,
                                    fit: BoxFit.fill,
                                    height: 56.h,
                                    width: 56.w,
                                  ),
                                  errorWidget: (context, url, error) => Image.asset(
                                    Assets.placeHolder,
                                    fit: BoxFit.fill,
                                    height: 56.h,
                                    width: 56.w,
                                  ),
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
                                  provider.spaceName ?? '',
                                  style: Style.commonTextStyle(
                                    color: textColor,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  '${S.of(context).incubatedSince} ${widget.companyManagementModel?.startDate?.year}',
                                  style: Style.commonTextStyle(
                                    color: grayTextColor,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ).visibility(visible: provider.spaceName != null && provider.spaceName!.isNotEmpty),
                        // SizedBox(
                        //   height: 16.h,
                        // ),
                        // Divider(
                        //   height: 1.h,
                        //   color: grayBorderColor,
                        //   thickness: 1,
                        // ),
                        // SizedBox(
                        //   height: 16.h,
                        // ),
                        // Align(
                        //   alignment: Alignment.centerLeft,
                        //   child: Text(
                        //     'Interests',
                        //     style: Style.commonTextStyle(
                        //       color: textColor,
                        //       fontSize: 18.sp,
                        //       fontWeight: FontWeight.w400,
                        //     ),
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: 12.h,
                        // ),
                        // SizedBox(
                        //   height: 40.h,
                        //   child: ListView.separated(
                        //     scrollDirection: Axis.horizontal,
                        //     itemBuilder: (context, index) {
                        //       return Container(
                        //         padding: EdgeInsets.symmetric(
                        //           horizontal: 15.w,
                        //           vertical: 10.h,
                        //         ),
                        //         alignment: Alignment.center,
                        //         decoration: BoxDecoration(
                        //           borderRadius: BorderRadius.circular(20.r),
                        //           color: grayF5,
                        //         ),
                        //         child: Text(
                        //           provider.lstService[index].companyService ?? '',
                        //           style: Style.commonTextStyle(
                        //             color: darkBorderColor,
                        //             fontSize: 14.sp,
                        //             fontWeight: FontWeight.w400,
                        //           ),
                        //         ),
                        //       );
                        //     },
                        //     separatorBuilder: (context, index) {
                        //       return SizedBox(
                        //         width: 16.h,
                        //       );
                        //     },
                        //     itemCount: provider.lstService.length,
                        //   ),
                        // ),
                        SizedBox(
                          height: 20.h,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
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
                // call permissions for contacts, to save user info to contact
                onTap: widget.isFromProfile
                    ? () {
                        AppRouter.pushNamed(Routes.editProfileDetailsScreen);
                      }
                    : notifier.askPermissions,
                child: Container(
                  height: 33.h,
                  width: 33.h,
                  margin: EdgeInsets.only(
                    top: context.statusBarHeight,
                    right: 20.w,
                  ),
                  decoration: const BoxDecoration(
                    color: activeBgColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    widget.isFromProfile ? Icons.edit : Icons.file_download_outlined,
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
