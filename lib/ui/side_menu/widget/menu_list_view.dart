import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/ui/side_menu/provider/side_menu_provider.dart';

class MenuListView extends StatelessWidget {
  const MenuListView({required this.notifier, super.key});

  final SideMenuNotifier notifier;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (_, index) {
          final item = notifier.lstMenu[index];
          return InkWell(
            onTap: () =>
              notifier.onItemTap(index: index),
            child: Row(
              children: [
                SvgPicture.asset(
                  item.icon!,
                  height: 24.h,
                  width: 24.w,
                  colorFilter:
                      const ColorFilter.mode(darkBorderColor, BlendMode.srcIn),
                ),
                SizedBox(
                  width: 8.w,
                ),
                Text(
                  item.name ?? '',
                  style: Style.commonTextStyle(
                    color: textColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
          );
        },
        separatorBuilder: (_, index) {
          return  index == notifier.lstMenu.length-2
              ? Divider(
                  height: 50.h,
                  thickness: 1.h,
                )
              : SizedBox(
                  height: 25.h,
                );
        },
        itemCount: notifier.lstMenu.length,
      ),
    );
  }
}
