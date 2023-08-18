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
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaY: 10,
          sigmaX: 10,
        ),
        child: Container(
          width: context.screenWidth - 55.w,
          padding: EdgeInsets.only(
            left: 16.w,
            right: 16.w,
            top: 64.h,
          ),
          decoration: BoxDecoration(color: Colors.white.withOpacity(0.83)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(width: 50.w,),
                  Expanded(
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
                ],
              ),
              // Consumer(
              //   builder: (BuildContext context, WidgetRef ref, Widget? child) {
              //     final provider = ref.watch(sideMenuProvider);
              //     final notifier = ref.read(sideMenuProvider.notifier);
              //     return Container(
              //       height: 50.h,
              //       decoration: BoxDecoration(
              //         border: Border.all(),
              //         borderRadius: BorderRadius.circular(25.r),
              //       ),
              //       child: ListView.separated(
              //         shrinkWrap: true,
              //         padding: EdgeInsets.symmetric(horizontal: 7.w),
              //         scrollDirection: Axis.horizontal,
              //         physics: const NeverScrollableScrollPhysics(),
              //         itemBuilder: (_, index) {
              //           final item = provider.lstTheme![index];
              //           return InkWell(
              //             onTap: () {
              //               notifier.updateTheme(index);
              //             },
              //             child: Container(
              //               height: 40.h,
              //               width: 40.w,
              //               alignment: Alignment.center,
              //               decoration: BoxDecoration(
              //                 color: item.isSelected ?? false
              //                     ? darkPrimaryColor
              //                     : Colors.transparent,
              //                 shape: BoxShape.circle,
              //               ),
              //               child: SvgPicture.asset(
              //                 item.icon!,
              //                 height: 20.h,
              //                 width: 20.w,
              //                 colorFilter: ColorFilter.mode(
              //                   item.isSelected ?? false
              //                       ? whiteColor
              //                       : blackColor,
              //                   BlendMode.srcIn,
              //                 ),
              //               ),
              //             ),
              //           );
              //         },
              //         separatorBuilder: (_, index) {
              //           return SizedBox(
              //             width: 7.w,
              //           );
              //         },
              //         itemCount: provider.lstTheme!.length,
              //       ),
              //     );
              //   },
              // ),
              MenuListView(notifier: notifier)
            ],
          ),
        ),
      ),
    );
  }
}
