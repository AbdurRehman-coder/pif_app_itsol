import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/extensions/context_extensions.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/widget/background_widget.dart';
import 'package:pif_flutter/common/shared/widget/banner_video_view.dart';
import 'package:pif_flutter/helpers/constants.dart';
import 'package:pif_flutter/ui/on_boarding/fill_information/provider/fill_information_provider.dart';
import 'package:pif_flutter/ui/on_boarding/fill_information/widget/bottom_button.dart';
import 'package:pif_flutter/ui/on_boarding/fill_information/widget/check_privacy.dart';
import 'package:pif_flutter/ui/on_boarding/fill_information/widget/personal_information.dart';

class FillAllInformationScreen extends ConsumerStatefulWidget {
  const FillAllInformationScreen({
    required this.userName,
    super.key,
  });

  final String userName;

  @override
  ConsumerState createState() => _FillAllInformationScreenState();
}

class _FillAllInformationScreenState extends ConsumerState<FillAllInformationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BackgroundWidget(
        child: Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            final provider = ref.watch(fillInformationProvider);
            final notifier = ref.read(fillInformationProvider.notifier);
            return SingleChildScrollView(
              controller: provider.scrollControllerFillInformation,
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: KeyboardVisibilityBuilder(
                builder: (context, isKeyboardOpen) {
                  if (isKeyboardOpen && !notifier.idNumberFocusNode.hasFocus) {
                    provider.scrollControllerFillInformation.animateTo(
                      310,
                      duration: const Duration(milliseconds: 100),
                      curve: Curves.easeIn,
                    );
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 60.h),
                      Text(
                        '${S.current.hi}${widget.userName}!',
                        style: Style.commonTextStyle(
                          color: dayTextColor,
                          fontSize: 32.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        provider.contentModel?.value?.contentFields
                                ?.where(
                                  (element) => element.name == 'onboardingText',
                                )
                                .firstOrNull
                                ?.contentFieldValue
                                ?.data ??
                            '',
                        style: Style.commonTextStyle(
                          color: hintColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                        ),
                        maxLines: 4,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 40.h),
                          SizedBox(
                            height: 200.h,
                            width: double.infinity,
                            child: Builder(
                              builder: (context) {
                                final videoUrl = Constants.baseUrl +
                                    (provider.contentModel?.value?.contentFields!
                                                .where(
                                                  (element) => element.name == 'onBoardingVideo',
                                                )
                                                .firstOrNull
                                                ?.contentFieldValue
                                                ?.document!
                                                .contentUrl ??
                                            '')
                                        .replaceAll('+', '%20');

                                return BannerVideoView(
                                  videoUrl: videoUrl,
                                );
                              },
                            ),
                          ).shimmerLoadingSecond(
                            loading: provider.contentModel!.isLoading,
                          ),
                          PersonalInformation(
                            isKeyBoardVisible: isKeyboardOpen,
                          ),
                          SizedBox(height: 10.h),
                          const CheckPrivacy(),
                          if (notifier.idNumberFocusNode.hasFocus || isKeyboardOpen) ...[
                            SizedBox(
                              height: context.screenHeight > 900
                                  ? Platform.isIOS
                                      ? 540.h
                                      : 480.h
                                  : 530.h,
                            ),
                          ] else ...[
                            SizedBox(height: 150.h),
                          ],
                        ],
                      ),
                    ],
                  );
                },
              ),
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: const BottomButton(),
    );
  }
}
