import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/ui/visit_list/widget/image_profile_visitor.dart';

class SingleVisitor extends StatelessWidget {
  const SingleVisitor({
    required this.firstName,
    required this.lastName,
    required this.status,
    required this.visitorEmail,
    this.isVerified = true,
    this.showStatus = false,
    super.key,
  });

  final String firstName;
  final String lastName;
  final String visitorEmail;
  final bool status;
  final bool showStatus;
  final bool isVerified;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ImageProfileVisitor(
          firstName: firstName,
          lastName: lastName,
          status: status,
        ),
        SizedBox(width: 8.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$firstName $lastName',
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
                  SvgPicture.asset(isVerified ? Assets.check : Assets.shield),
                  SizedBox(width: 2.w),
                  Text(
                    isVerified ? S.of(context).verified : S.of(context).unverified,
                    style: Style.commonTextStyle(
                      color: isVerified ? primaryColor : gradientEnd,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
            Text(
              visitorEmail,
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
