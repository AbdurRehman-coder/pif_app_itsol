import 'package:flutter/material.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/routes/routes.dart';
import 'package:pif_flutter/ui/home/model/today_status_model.dart';

class TodayStatus extends StatelessWidget {
  const TodayStatus({super.key});

  TodayStatusModel get getImageByStats {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return TodayStatusModel(
        statusText: S.current.goodMorning,
        statusBackgroundImage: Assets.morningBackground,
      );
    }
    if (hour < 17) {
      return TodayStatusModel(
        statusText: S.current.goodAfternoon,
        statusBackgroundImage: Assets.afterNoonBackground,
      );
    }
    return TodayStatusModel(
      statusText: S.current.goodEvening,
      statusBackgroundImage: Assets.eveningBackground,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => AppRouter.pushNamed(Routes.companyServiceScreen),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(
          vertical: 24.h,
          horizontal: 23.w,
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              getImageByStats.statusBackgroundImage,
            ),
            fit: BoxFit.fill,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                '${getImageByStats.statusText},\nMuath!',
                style: Style.commonTextStyle(
                  color: whiteColor,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Text(
              '27°',
              style: Style.commonTextStyle(
                color: whiteColor,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
      ),
    );
  }
}
