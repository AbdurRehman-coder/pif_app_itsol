import 'package:dixels_sdk/features/commerce/visit/models/visitor_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pif_flutter/common/extensions/string_extensions.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/widget/image_profile_visitor.dart';

class SingleVisitor extends StatelessWidget {
  const SingleVisitor({
    required this.visitorsModel,
    this.isVerified = true,
    this.showStatus = false,
    super.key,
    required this.status,
  });

  final VisitorModel? visitorsModel;
  final bool status;
  final bool showStatus;
  final bool isVerified;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ImageProfileVisitor(
          firstName: visitorsModel?.givenName ?? '',
          lastName: visitorsModel?.familyName ?? '',
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                visitorsModel?.name!.capitalizeTheFirstLetter() ?? '',
                style: Style.commonTextStyle(
                  color: blackColorWith900,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                visitorsModel?.emailAddress ?? '',
                style: Style.commonTextStyle(
                  color: blackColor.withOpacity(0.6),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              if (showStatus) ...[
                SizedBox(height: 5.h),
                Row(
                  children: [
                    SvgPicture.asset(
                      visitorsModel!.customFields![0].name == 'isVerified'
                          ? Assets.check
                          : Assets.shield,
                      height: 15.h,
                      width: 15.w,
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      visitorsModel!.customFields![0].name == 'isVerified'
                          ? S.of(context).verified
                          : S.of(context).unverified,
                      style: Style.commonTextStyle(
                        color:
                            visitorsModel!.customFields![0].name == 'isVerified'
                                ? primaryColor
                                : secondary,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
