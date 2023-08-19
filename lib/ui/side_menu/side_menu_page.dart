import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/extensions/context_extensions.dart';
import 'package:pif_flutter/common/extensions/image_extensions.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/widget/image_profile_visitor.dart';
import 'package:pif_flutter/ui/dashboard/provider/dashboard_provider.dart';
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
    final providerDashboard = ref.watch(dashboardProvider);
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
                      child: providerDashboard.userDetails!.image != null
                          ? CachedNetworkImage(
                              imageUrl: providerDashboard
                                  .userDetails!.image!.getImageUrl,
                              fit: BoxFit.cover,
                            )
                          : ImageProfileVisitor(
                              firstName:
                                  providerDashboard.userDetails!.givenName ??
                                      '',
                              lastName:
                                  providerDashboard.userDetails!.familyName ??
                                      '',
                            ),
                    ),
                  ),
                  SizedBox(
                    width: 15.w,
                  ),
                  Expanded(
                    child: Text(
                      providerDashboard.userDetails!.name ?? '',
                      style: Style.commonTextStyle(
                        color: textColor,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    width: 50.w,
                  ),
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
              MenuListView(notifier: notifier)
            ],
          ),
        ),
      ),
    );
  }
}
