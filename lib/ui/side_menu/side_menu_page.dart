import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/extensions/context_extensions.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/ui/side_menu/provider/side_menu_provider.dart';
import 'package:pif_flutter/ui/side_menu/widget/menu_list_view.dart';

class SideMenuPage extends ConsumerStatefulWidget {
  const SideMenuPage({super.key});

  @override
  ConsumerState createState() => _SideMenuPageState();
}

class _SideMenuPageState extends ConsumerState<SideMenuPage> {
  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(sideMenuProvider.notifier);
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaY: 2,
      ),
      child: Container(
        width: context.screenWidth - 55.w,
        padding: EdgeInsets.only(
          left: 16.w,
          right: 16.w,
          top: context.statusBarHeight,
        ),
        decoration: BoxDecoration(color: Colors.white.withOpacity(0.9)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () {
                  Scaffold.of(context).closeDrawer();
                },
                icon: SvgPicture.asset(
                  Assets.cancelIcon,
                  height: 24.h,
                  width: 24.w,
                ),
              ),
            ),
            Row(
              children: [
                Container(
                  height: 42.h,
                  width: 42.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: grayBorder),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(21.r),
                    child: CachedNetworkImage(
                      imageUrl: 'https://picsum.photos/200/300',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  width: 15.w,
                ),
                Text(
                  'Muath Awad',
                  style: Style.commonTextStyle(
                    color: textColor,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
            MenuListView(notifier: notifier)
          ],
        ),
      ),
    );
  }
}
