import 'package:avatar_stack/avatar_stack.dart';
import 'package:avatar_stack/positions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/extensions/context_extensions.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/ui/drinks/index.dart';

class DrinksBagView extends ConsumerWidget {
  const DrinksBagView({
    required this.provider,
    super.key,
  });

  final DrinksState provider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = RestrictedPositions(
      align: StackAlign.right,
      maxCoverage: 0.3,
      minCoverage: 0.2,
    );
    return Container(
      height: 70.h,
      width: context.screenWidth - 40,
      padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    S.current.drinksBag,
                    style: Style.commonTextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: whiteColor,
                    ),
                  ),
                  SizedBox(
                    width: 12.w,
                  ),
                  SvgPicture.asset(
                    Assets.arrowRight,
                    colorFilter: const ColorFilter.mode(
                      whiteColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ],
              ),
              Text(
                '${provider.lstCarts.length} Item',
                style: Style.commonTextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w300,
                  color: whiteColor,
                ),
              ),
            ],
          ),
          const Spacer(),
          Expanded(
            child: Align(
              alignment: Alignment.topRight,
              child: AvatarStack(
                height: 40.h,
                borderColor: loggedStatusColor,
                borderWidth: 0.5,
                settings: settings,
                infoWidgetBuilder: (surplus) => BorderedCircleAvatar(
                  backgroundColor: primaryColor,
                  child: Text(
                    '+$surplus',
                    textAlign: TextAlign.center,
                    style: Style.commonTextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: whiteColor,
                    ),
                  ),
                ),
                avatars: [
                  for (var i = 0; i < provider.lstCarts.length; i++)
                    NetworkImage(
                      provider.lstCarts[i].imageUrl,
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
