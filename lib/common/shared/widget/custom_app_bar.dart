import 'package:flutter/material.dart';
import 'package:pif_flutter/common/index.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: whiteColor,
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
      title: Text(
        title,
        style: Style.commonTextStyle(
          color: textColor,
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60.h);
}
