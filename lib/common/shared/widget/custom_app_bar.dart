import 'package:flutter/material.dart';
import 'package:pif_flutter/common/index.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    this.title,
    this.actionWidget,
    super.key,
    this.titleWidget,
    this.bgColor,
  });

  final String? title;
  final Widget? titleWidget;
  final List<Widget>? actionWidget;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: bgColor,
      elevation: 0,
      centerTitle: true,
      leading: InkWell(
        onTap: AppRouter.pop,
        child: Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: Container(
            height: 40.h,
            width: 40.w,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: activeBgColor,
            ),
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: dayTextColor,
              size: 20,
            ),
          ),
        ),
      ),
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              whiteColor,
              whiteColor,
              whiteColor,
              whiteColor,
              whiteColor,
              whiteColor,
              expireBgColor,
            ],
          ),
        ),
      ),
      title: titleWidget ??
          Text(
            title ?? '',
            style: Style.commonTextStyle(
              color: textColor,
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
      actions: actionWidget,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60.h);
}
