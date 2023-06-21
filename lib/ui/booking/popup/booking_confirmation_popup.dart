import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/ui/booking/index.dart';

void bookingConfirmationPopup({required BuildContext context, required bool isRequestBooking}) {
  showModalBottomSheet<dynamic>(
    backgroundColor: whiteColor,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(24.r),
        topRight: Radius.circular(24.r),
      ),
    ),
    context: context,
    builder: (BuildContext context) {
      return Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          final provider = ref.watch(bookingConfirmationProvider);
          return Container(
            height: isRequestBooking ? 400.h : 355.h,
            padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 25.h),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Column(
                      children: [
                        Align(
                          child: SvgPicture.asset(
                            isRequestBooking ? Assets.requestBookingConf : Assets.bookConfirmation,
                          ),
                        ),
                        SizedBox(
                          height: 7.h,
                          child: SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              trackHeight: 1,
                              thumbColor: Colors.transparent,
                              disabledActiveTrackColor: primaryColor,
                              disabledInactiveTrackColor: inactiveTrackColor,
                              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 0),
                            ),
                            child: Slider(
                              value: provider.sliderValue.toDouble(),
                              max: 3000,
                              onChanged: null,
                            ),
                          ),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: AppRouter.pop,
                      child: Text(
                        S.of(context).skip,
                        style: Style.commonTextStyle(
                          color: primaryColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  isRequestBooking ? S.of(context).requestBookTitle : S.of(context).bookingRoom,
                  textAlign: TextAlign.center,
                  style: Style.commonTextStyle(
                    height: 1.2,
                    color: textColor,
                    fontSize: 23.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: S.of(context).bookedByMistake,
                        recognizer: TapGestureRecognizer()..onTap = () {},
                        style: Style.commonTextStyle(
                          color: grayTextColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const TextSpan(text: ' '),
                      TextSpan(
                        text: isRequestBooking ? S.of(context).cancelRequest : S.of(context).cancel,
                        recognizer: TapGestureRecognizer()..onTap = () {},
                        style: Style.commonTextStyle(
                          color: redColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      );
    },
  );
}
