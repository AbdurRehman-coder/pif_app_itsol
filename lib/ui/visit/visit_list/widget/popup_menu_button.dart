import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/widget/alert_popup.dart';

class CustomPopupMenuButton extends StatelessWidget {
  const CustomPopupMenuButton({super.key, this.isFromDetails = false});
  final bool? isFromDetails;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      padding: EdgeInsets.only(top: 5.h),
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
      icon: Align(
        alignment: Alignment.topRight,
        child: isFromDetails!
            ? Container(
                height: 34.h,
                width: 34.w,
                padding: EdgeInsets.zero,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: activeBgColor,
                ),
                child: const Icon(
                  Icons.more_vert_outlined,
                  color: grayTextColor,
                ),
              )
            : const Icon(
                Icons.more_vert_outlined,
                color: grayTextColor,
              ),
      ),
      color: whiteColor,
      elevation: 2,
    );
  }
}
