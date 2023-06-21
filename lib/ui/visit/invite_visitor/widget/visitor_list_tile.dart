import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/ui/visit/invite_visitor/index.dart';

class VisitorListTile extends StatelessWidget {
  const VisitorListTile({required this.item, required this.notifier, super.key});

  final InviteVisitorModel item;
  final InviteVisitorNotifier notifier;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 40.h,
          width: 40.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Text(
            item.shortName,
            style: Style.commonTextStyle(
              color: whiteColor,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
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
                  color: textColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
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
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () {
            notifier.removeVisitor(item);
          },
          icon: SvgPicture.asset(
            Assets.close,
            height: 24.h,
          ),
        ),
      ],
    );
  }
}
