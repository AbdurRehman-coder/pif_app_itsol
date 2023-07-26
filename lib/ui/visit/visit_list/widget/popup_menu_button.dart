import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/widget/alert_popup.dart';

class CustomPopupMenuButton extends StatelessWidget {
  const CustomPopupMenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          onTap: () {},
          child: Row(
            children: [
              SvgPicture.asset(
                Assets.editIcon,
              ),
              SizedBox(
                width: 10.w,
              ),
              Text(
                S.of(context).edit,
                style: Style.commonTextStyle(
                  color: dayTextColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              )
            ],
          ),
        ),
        PopupMenuItem(
          value: 2,
          child: Row(
            children: [
              SvgPicture.asset(
                Assets.duplicateIcon,
              ),
              SizedBox(
                width: 10.w,
              ),
              Text(
                S.of(context).duplicate,
                style: Style.commonTextStyle(
                  color: dayTextColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              )
            ],
          ),
        ),
        PopupMenuItem(
          value: 3,
          onTap: () => Future.delayed(
            const Duration(milliseconds: 200),
            () {
              alertPopup(
                context: context,
                deleteMessage: S.current.deleteVisitMessage,
                onClickYes: () {},
              );
            },
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                Assets.trashBit,
              ),
              SizedBox(
                width: 10.w,
              ),
              Text(
                S.of(context).delete,
                style: Style.commonTextStyle(
                  color: dayTextColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              )
            ],
          ),
        ),
      ],
      icon: SvgPicture.asset(
        Assets.optionMenuIcon,
      ),
      color: whiteColor,
      elevation: 2,
    );
  }
}
