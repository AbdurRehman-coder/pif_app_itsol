import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/extensions/context_extensions.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/widget/custom_lottie_widget.dart';
import 'package:pif_flutter/ui/dashboard/provider/dashboard_provider.dart';
import 'package:pif_flutter/widgets/circular_menu/circular_menu.dart';

class CircleMenu extends ConsumerWidget {
  const CircleMenu({
    required this.animationController,
    required this.isHided,
    super.key,
  });

  final AnimationController animationController;
  final bool isHided;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(dashboardProvider);
    final notifier = ref.read(dashboardProvider.notifier);

    return Positioned.fill(
      bottom: Platform.isIOS ? 60.h : 30.h,
      child: CircularMenu(
        toggleButtonMargin: 0,
        isHided: isHided,
        onChanged: (value) {},
        toggleButtonColor: primaryDark,
        openToggleIcon: Container(
          padding: EdgeInsets.symmetric(horizontal: 7.w,vertical: 7.h),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: primaryDark,
          ),
          child: SvgPicture.asset(
            Assets.instant,
            fit: BoxFit.cover,
            width: 24.w,
            height: 24.h,
          ),
        ),
        closeToggleIcon: Container(
          width: 40.w,
          height: 40.h,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: primaryDark,
          ),
          child: const Icon(
            Icons.close,
            color: whiteColor,
          ),
        ),
        items: List.generate(
          provider.actionList.value!.length,
          (index) => CircularMenuItem(
            icon: Container(
              height: 50.h,
              width: 50.w,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: whiteColor,
              ),
              child: CustomLottieWidget(
                lottieUrl: provider.actionList.value![index].actionImage,
                isAssets: true,
              ),
            ),
            color: whiteColor,
            onTap: () {
              if (index == 0) {
                notifier.orderNow(context: context);
              }
              if (index == 2) {
                notifier.digitalVipSupportAsync(context: context);
              }
              if (index == 3) {
                notifier.operationalSupportAsync(context: context);
              }
            },
          ),
        ).toList(),
        animationController: animationController,
      ),
    );
  }
}
