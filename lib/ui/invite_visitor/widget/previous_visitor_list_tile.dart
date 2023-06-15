import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/ui/invite_visitor/model/invite_visitor_model.dart';
import 'package:pif_flutter/ui/invite_visitor/provider/previous_visitor_provider.dart';

class PreviousVisitorListTile extends StatelessWidget {
  const PreviousVisitorListTile({required this.item, required this.notifier, super.key});

  final InviteVisitorModel item;
  final PreviousVisitorNotifier notifier;

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
              Row(
                children: [
                  SvgPicture.asset(Assets.verifyStatus),
                  SizedBox(
                    width: 6.w,
                  ),
                  Text(
                    item.status ?? '',
                    style: Style.commonTextStyle(
                      color: primaryColor,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Checkbox(
          value: item.isSelected,
          onChanged: (value) {
            notifier.updateListData(item);
          },
        )
      ],
    );
  }
}
