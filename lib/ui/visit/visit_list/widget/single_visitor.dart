import 'package:dixels_sdk/features/commerce/visit/models/visitor_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/ui/visit/widget/image_profile_visitor.dart';

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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              visitorsModel?.name ?? '',
              style: Style.commonTextStyle(
                color: darkTextColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            if (showStatus) ...[
              SizedBox(height: 3.h),
              Row(
                children: [
                  SvgPicture.asset(
                    visitorsModel!.customFields![0].customValue!.data!
                        ? Assets.check
                        : Assets.shield,
                  ),
                  SizedBox(width: 2.w),
                  Text(
                    visitorsModel!.customFields![0].customValue!.data!
                        ? S.of(context).verified
                        : S.of(context).unverified,
                    style: Style.commonTextStyle(
                      color: visitorsModel!.customFields![0].customValue!.data!
                          ? primaryColor
                          : gradientEnd,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
            Text(
              visitorsModel?.emailAddress ?? '',
              style: Style.commonTextStyle(
                color: silverTextColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
