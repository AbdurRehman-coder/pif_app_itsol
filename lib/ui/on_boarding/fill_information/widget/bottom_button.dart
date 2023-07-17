import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/routes/routes.dart';
import 'package:pif_flutter/ui/on_boarding/fill_information/provider/fill_information_provider.dart';
import 'package:pif_flutter/ui/on_boarding/login/provider/login_provider.dart';

class BottomButton extends ConsumerWidget {
  const BottomButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(fillInformationProvider.notifier);
    final provider = ref.watch(fillInformationProvider);
    final notifierLogIn = ref.read(logInProvider.notifier);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 15.h,
            child: ListView.separated(
              itemCount: 2,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) {
                return Container(
                  height: 15.h,
                  width: 15.w,
                  decoration: BoxDecoration(
                    color: provider.selectedScreen == index
                        ? primaryColor
                        : primaryDisabledColor,
                    shape: BoxShape.circle,
                  ),
                );
              },
              separatorBuilder: (_, index) {
                return SizedBox(width: 5.w);
              },
            ),
          ),
          SizedBox(height: 20.h),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryDisabledColor,
                padding: EdgeInsets.symmetric(vertical: 10.h),
              ),
              onPressed: notifier.updateIndexSelect,
              child: Text(
                S.current.next,
                style: Style.commonTextStyle(
                  color: whiteColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ).visibility(visible: provider.selectedScreen == 0),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                  ),
                  onPressed: notifier.removeSelectedImageFace,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(Assets.arOnYou),
                      SizedBox(width: 5.w),
                      Text(
                        S.current.scan,
                        style: Style.commonTextStyle(
                          color: whiteColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: whiteColor,
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    side: const BorderSide(color: primaryColor),
                  ),
                  onPressed: () => notifierLogIn.createLogIn(context: context),
                  child: Text(
                    S.current.scanLater,
                    style: Style.commonTextStyle(
                      color: primaryColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          ).visibility(
            visible: provider.selectedScreen == 1 && provider.scanFace == null,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                  ),
                  onPressed: () => notifierLogIn.createLogIn(context: context),
                  child: Text(
                    S.current.getStarted,
                    style: Style.commonTextStyle(
                      color: whiteColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: whiteColor,
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    side: const BorderSide(color: primaryColor),
                  ),
                  onPressed: notifier.removeSelectedImageFace,
                  child: Text(
                    S.current.scanAgain,
                    style: Style.commonTextStyle(
                      color: primaryColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          ).visibility(
            visible: provider.selectedScreen == 1 && provider.scanFace != null,
          ),
        ],
      ),
    );
  }
}