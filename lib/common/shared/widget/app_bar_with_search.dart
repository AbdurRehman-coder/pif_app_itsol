import 'package:flutter/material.dart';
import 'package:pif_flutter/common/index.dart';

class AppBarWithCustomTitle extends StatelessWidget
    implements PreferredSizeWidget {
  const AppBarWithCustomTitle({this.title, super.key});

  final Widget? title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: expireBgColor,
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
      title: title,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(75.h);
}
