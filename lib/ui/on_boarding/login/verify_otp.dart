import 'package:flutter/material.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/widget/custom_app_bar.dart';
import 'package:pif_flutter/ui/on_boarding/login/widget/background_widget_with_logo.dart';
import 'package:pif_flutter/ui/on_boarding/login/widget/pinput_widget.dart';
import 'package:pif_flutter/ui/on_boarding/widget/tile_card.dart';

class VerifyOTP extends StatelessWidget {
  const VerifyOTP({super.key});

  @override
  Widget build(BuildContext context) {
    const borderColor = Color.fromRGBO(23, 171, 144, 0.4);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: grayF5,
      appBar: const CustomAppBar(
        title: '',
      ),
      body: BackgroundWidgetWithLogo(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                SizedBox(height: 16.h),
                TileCard(
                  title: S.current.verification,
                  description: S.current.weOfferPasswordExperience,
                ),
                SizedBox(height: 32.h),
                const Center(
                  child: PinPutWidget(),
                ),
                SizedBox(height: 20.h),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: S.current.resendEmail,
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 14.sp,
                        ),
                      )
                    ],
                    text: S.current.receiveAnEmail,
                    style: TextStyle(
                      color: dayTextColor,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
