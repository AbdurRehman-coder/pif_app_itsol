import 'package:dixels_sdk/dixels_sdk.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/helpers/constants.dart';
import 'package:pif_flutter/ui/home/widget/banner_video_view.dart';
import 'package:pif_flutter/ui/on_boarding/fill_information/provider/fill_information_provider.dart';
import 'package:pif_flutter/ui/on_boarding/fill_information/widget/check_privacy.dart';
import 'package:pif_flutter/ui/on_boarding/fill_information/widget/personal_information.dart';
import 'package:video_player/video_player.dart';

class FillPersonalInformation extends StatefulWidget {
  const FillPersonalInformation({
    required this.userName,
    super.key,
  });

  final String userName;

  @override
  State<FillPersonalInformation> createState() =>
      _FillPersonalInformationState();
}

class _FillPersonalInformationState extends State<FillPersonalInformation> {
  bool showBottomButton = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final provider = ref.watch(fillInformationProvider);
        final notifier = ref.read(fillInformationProvider.notifier);
        return Expanded(
          child: SingleChildScrollView(
            controller: provider.scrollControllerFillInformation,
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 55.h),
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
                          ?.where((element) => element.name == 'onboardingText')
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
                                        (element) =>
                                            element.name == 'onBoardingVideo',
                                      )
                                      .firstOrNull
                                      ?.contentFieldValue
                                      ?.document!
                                      .contentUrl ??
                                  '');
                          return BannerVideoView(
                            videoUrl: videoUrl,
                          );
                        },
                      ),
                    ).shimmerLoadingSecond(
                      loading: provider.contentModel!.isLoading,
                    ),
                    const PersonalInformation(),
                    SizedBox(height: 10.h),
                    const CheckPrivacy(),
                    if (notifier.idNumberFocusNode.hasFocus) ...[
                      SizedBox(height: 430.h),
                    ] else ...[
                      SizedBox(height: 150.h),
                    ],
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
