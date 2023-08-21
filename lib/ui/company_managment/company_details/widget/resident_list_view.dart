import 'package:cached_network_image/cached_network_image.dart';
import 'package:dixels_sdk/features/commerce/company_managment/model/company_management_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pif_flutter/common/extensions/image_extensions.dart';
import 'package:pif_flutter/helpers/assets.dart';
import 'package:pif_flutter/routes/app_router.dart';
import 'package:pif_flutter/routes/routes.dart';
import 'package:pif_flutter/utils/colors.dart';
import 'package:pif_flutter/utils/styles.dart';

class ResidentListView extends StatelessWidget {
  const ResidentListView({super.key, required this.data});

  final CompanyManagementModel data;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final item = data.residents![index];
        final isVIP =
            item.customFields != null ? item.customFields!.firstWhere((element) => element.name == 'Is VIP').customValue.data.toString() : '';
        return InkWell(
          onTap: () => AppRouter.pushNamed(
            Routes.employeeDetailsScreen,
            args: [
              false,
              item,
              data,
            ],
          ),
          child: Row(
            children: [
              Container(
                height: 42.h,
                width: 42.w,
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
                    height: 42.r,
                    width: 42.r,
                    imageUrl: item.image != null ? data.residents![index].image!.getImageUrl : '',
                    placeholder: (context, url) => Image.asset(
                      Assets.placeHolder,
                      fit: BoxFit.fill,
                      height: 42.r,
                      width: 42.r,
                    ),
                    errorWidget: (context, url, error) => Container(
                      height: 42.r,
                      width: 42.r,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: RegExp(r'^[A-E_.]+$').hasMatch(
                          item.givenName![0].toUpperCase(),
                        )
                            ? primary800
                            : RegExp(r'^[J-M_.]+$').hasMatch(
                                item.givenName![0].toUpperCase(),
                              )
                                ? blue400
                                : RegExp(r'^[N-S_.]+$').hasMatch(
                                    item.givenName![0].toUpperCase(),
                                  )
                                    ? pink200
                                    : primary300,
                      ),
                      child: Text(
                        ' ${item.givenName![0]}${item.familyName![0]}'.toUpperCase(),
                        style: Style.commonTextStyle(
                          color: whiteColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
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
                    item.name ?? '',
                    style: Style.commonTextStyle(
                      color: textColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    item.jobTitle ?? '',
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
      itemCount: data.residents!.length,
    );
  }
}
