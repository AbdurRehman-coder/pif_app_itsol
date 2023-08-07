import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/ui/visit/invite_edit_visit/index.dart';

import 'package:pif_flutter/common/shared/widget/image_profile_visitor.dart';

class VisitorListTile extends StatelessWidget {
  const VisitorListTile({
    required this.item,
    required this.notifier,
    this.isInviteVisit = true,
    super.key,
  });

  final InviteVisitorModel item;
  final bool isInviteVisit;
  final InviteVisitorNotifier notifier;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.h),
      decoration: BoxDecoration(
        border: Border.all(color: grey400),
        borderRadius: BorderRadius.all(
          Radius.circular(6.r),
        ),
      ),
      child: Row(
        children: [
          ImageProfileVisitor(
            lastName: item.lastName ?? '',
            firstName: item.firstName ?? '',
          ),
          SizedBox(
            width: 16.w,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Style.commonTextStyle(
                    color: blackColorWith900,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  item.email ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Style.commonTextStyle(
                    color: textColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          if (isInviteVisit) ...[
            IconButton(
              onPressed: () => notifier.removeVisitor(item),
              icon: SvgPicture.asset(
                Assets.close,
                width: 20.w,
                height: 20.h,
                fit: BoxFit.fill,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
