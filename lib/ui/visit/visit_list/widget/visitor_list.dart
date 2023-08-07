import 'package:dixels_sdk/features/commerce/visit/models/visitor_model.dart';
import 'package:flutter/material.dart';
import 'package:pif_flutter/common/extensions/string_extensions.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/widget/image_profile_visitor.dart';

class VisitorList extends StatelessWidget {
  const VisitorList({
    required this.visitModel,
    super.key,
  });

  final List<VisitorModel>? visitModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) {
            final user = visitModel?[index];
            return SizedBox(
              width: 40.h,
              child: Column(
                children: [
                  ImageProfileVisitor(
                    firstName: user?.givenName ?? '',
                    lastName: user?.familyName ?? '',
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    '${user?.givenName!.capitalizeTheFirstLetter() ?? ''} ${(user?.familyName!.capitalizeTheFirstLetter() ?? '')[0]}',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Style.commonTextStyle(
                      color: gradientStart,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ).visibility(visible: index < 3);
          },
          separatorBuilder: (_, index) {
            return SizedBox(
              width: index > 2 ? 0.w : 10.w,
            );
          },
          itemCount: visitModel != null ? visitModel!.length : 1,
        ),
        if (visitModel != null && visitModel!.length > 3) ...[
          Container(
            width: 40.w,
            height: 35.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: primaryColor.withOpacity(0.1),
            ),
            child: Center(
              child: Text(
                '+${visitModel!.length - 3}',
                style: Style.commonTextStyle(
                  color: primaryColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
