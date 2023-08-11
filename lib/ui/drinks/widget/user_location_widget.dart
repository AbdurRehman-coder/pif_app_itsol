import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/routes/routes.dart';
import 'package:pif_flutter/ui/drinks/state/drinks_state.dart';

class UserLocationWidget extends StatelessWidget {
  const UserLocationWidget(this.provider, {super.key});

  final DrinksState provider;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        AppRouter.pushNamed(Routes.searchLocationScreen);
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 14.w,
          vertical: 5.h,
        ),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(
            18.r,
          ),
          border: Border.all(
            color: grayBgColor,
            width: 1.r,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context).deliveringTo,
                  style: Style.commonTextStyle(
                    color: grayTextColor,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  provider.deliveryLocation != null ? provider.deliveryLocation?.name ?? '' : S.of(context).selectLocation,
                  style: Style.commonTextStyle(
                    color: blackColorWith900,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            SvgPicture.asset(Assets.locationPin),
          ],
        ),
      ),
    );
  }
}
