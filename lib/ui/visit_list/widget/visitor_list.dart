import 'package:flutter/material.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/ui/visit_list/provider/visit_list_provider.dart';
import 'package:pif_flutter/ui/visit_list/widget/image_profile_visitor.dart';

class VisitorList extends StatelessWidget {
  const VisitorList({
    required this.notifier,
    super.key,
  });

  final VisitListNotifier notifier;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) {
            final user = notifier.userVisitor[index];
            if (index < 3) {
              return Column(
                children: [
                  ImageProfileVisitor(
                    firstName: user,
                    lastName: user,
                    status: true,
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    user.substring(0, 6),
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
          itemCount: notifier.userVisitor.length,
        ),
        if (notifier.userVisitor.length > 3) ...[
          Container(
            width: 40.w,
            height: 35.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: primaryColor.withOpacity(0.1),
            ),
            child: Center(
              child: Text(
                '+${notifier.userVisitor.length - 3}',
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
