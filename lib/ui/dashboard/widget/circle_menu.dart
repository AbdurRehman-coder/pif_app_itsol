import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/ui/dashboard/provider/dashboard_provider.dart';
import 'package:pif_flutter/widgets/circular_menu/circular_menu.dart';

class CircleMenu extends ConsumerWidget {
  const CircleMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.read(dashboardProvider);
    return Positioned.fill(
      bottom: 60.h,
      child: CircularMenu(
        toggleButtonMargin: 0,
        onChanged: (value) {},
        toggleButtonColor: primaryDark,
        openToggleIcon: Container(
          width: 40.w,
          height: 40.h,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: primaryDark,
          ),
          child: SvgPicture.asset(
            Assets.instant,
            fit: BoxFit.cover,
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
              decoration:  BoxDecoration(
                shape: BoxShape.circle,
                color: whiteColor,
                image: DecorationImage(
                  image: NetworkImage(
                    provider.actionList.value![index].actionImage,
                  ),
                ),
              ),
            ),
            color: whiteColor,
            onTap: () {},
          ),
        ).toList(),
      ),
    );
  }
}
