import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/widget/banner_video_view.dart';
import 'package:pif_flutter/common/shared/widget/second_custom_text_field.dart';
import 'package:pif_flutter/helpers/constants.dart';
import 'package:pif_flutter/ui/on_boarding/login/provider/login_provider.dart';
import 'package:pif_flutter/ui/on_boarding/login/widget/background_widget_with_logo.dart';
import 'package:pif_flutter/ui/on_boarding/widget/tile_card.dart';

class LogInPage extends ConsumerStatefulWidget {
  const LogInPage({super.key});

  @override
  ConsumerState createState() => _LogInPageScreenState();
}

class _LogInPageScreenState extends ConsumerState<LogInPage> {
  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(logInProvider.notifier);
    final provider = ref.watch(logInProvider);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: grayF5,
      body: Form(
        key: notifier.formKeyLogIn,
        child: BackgroundWidgetWithLogo(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Text(S.current.lang),
                          SizedBox(width: 4.w),
                          const Icon(
                            Icons.language,
                            color: blackColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  TileCard(
                    title: S.current.login,
                    description: S.current.weOfferPasswordExperience,
                  ),
                  SizedBox(height: 20.h),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 200.h,
                            width: double.infinity,
                            child: Builder(
                              builder: (context) {
                                return BannerVideoView(
                                  videoUrl:
                                      '${Constants.baseUrl}/documents/20120/147621/Mobile%20Prelogin%20Intro%20Video.mp4/?videoPreview=1&type=mp4',
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 20.h),
                          SecondCustomTextField(
                            textEditingController: notifier.emailController,
                            keyboardType: TextInputType.emailAddress,
                            hintText: S.of(context).email,
                            focusNode: notifier.emailFocusNode,
                            isEmailField: true,
                            checkEmpty: true,
                            onTap: () => setStateF,
                          ),
                          SizedBox(height: 20.h),
                          SecondCustomTextField(
                            focusNode: notifier.passwordFocusNode,
                            textEditingController: notifier.passwordController,
                            keyboardType: TextInputType.visiblePassword,
                            hintText: S.of(context).password,
                            obscureText: true,
                            checkEmpty: true,
                          ),
                          SizedBox(height: 300.h),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 10.h),
            ),
            onPressed: () => notifier.createLogIn(context: context),
            child: Text(
              S.current.login,
              style: Style.commonTextStyle(
                color: whiteColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
