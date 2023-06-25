import 'package:dixels_sdk/features/commerce/visit/models/visitor_model.dart';
import 'package:flutter/material.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/ui/visit/visit_list/model/visit_model.dart';
import 'package:pif_flutter/ui/visit/widget/image_profile_visitor.dart';

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
            if (index < 3) {
              return Column(
                children: [
                  ImageProfileVisitor(
                    firstName: user?.givenName ?? '',
                    lastName: user?.givenName ?? '',
                    status: true,
                  ),
                  SizedBox(height: 5.h),
                  Text('${user?.givenName ?? ''} ${(user?.givenName ?? '')[0]}',
                    style: Style.commonTextStyle(
                      color: gradientStart,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              );
            } else {
              return const SizedBox();
            }
          },
          separatorBuilder: (_, index) {
            if (index != 2) {
              return SizedBox(width: 10.w);
            } else {
              return const SizedBox();
            }
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
