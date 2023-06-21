import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pif_flutter/generated/l10n.dart';
import 'package:pif_flutter/helpers/assets.dart';
import 'package:pif_flutter/utils/colors.dart';
import 'package:pif_flutter/utils/styles.dart';

void showSuccessMessage({
  required BuildContext context,
  required String titleText,
  required String subTitle,
  required void Function() navigateAfterEndTime,
  String? image,
  String? cancelText,
}) {
  showModalBottomSheet<dynamic>(
    backgroundColor: whiteColor,
    isScrollControlled: true,
    enableDrag: false,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(24.r),
        topRight: Radius.circular(24.r),
      ),
    ),
    context: context,
    builder: (BuildContext context) {
      return SuccessMessage(
        titleText: titleText,
        subTitle: subTitle,
        navigateAfterEndTime: navigateAfterEndTime,
      );
    },
  );
}

class SuccessMessage extends StatefulWidget {
  const SuccessMessage({
    required this.titleText,
    required this.subTitle,
    required this.navigateAfterEndTime,
    this.image,
    this.cancelText,
    super.key,
  });

  final String titleText;
  final String subTitle;
  final void Function() navigateAfterEndTime;
  final String? image;
  final String? cancelText;

  @override
  State<SuccessMessage> createState() => _SuccessMessageState();
}

class _SuccessMessageState extends State<SuccessMessage> {
  Timer? _timer;
  double sliderValue = 0;

  void _initTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      setState(() {
        sliderValue += 50;
      });
      if (sliderValue == 3000) {
        _timer?.cancel();
        widget.navigateAfterEndTime();
      }
    });
  }

  @override
  void initState() {
    _initTimer();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 25.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              Column(
                children: [
                  Align(
                    child: SvgPicture.asset(
                      widget.image ?? Assets.bookConfirmation,
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
                        thumbShape: const RoundSliderThumbShape(
                          enabledThumbRadius: 0,
                        ),
                      ),
                      child: Slider(
                        value: sliderValue,
                        max: 3000,
                        onChanged: null,
                      ),
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: widget.navigateAfterEndTime,
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
            widget.titleText,
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
                  text: widget.subTitle,
                  recognizer: TapGestureRecognizer()..onTap = () {},
                  style: Style.commonTextStyle(
                    color: grayTextColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const TextSpan(text: ' '),
                TextSpan(
                  text: widget.cancelText ?? S.of(context).cancel,
                  recognizer: TapGestureRecognizer()..onTap = () {},
                  style: Style.commonTextStyle(
                    color: redColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 57.h),
        ],
      ),
    );
  }
}
