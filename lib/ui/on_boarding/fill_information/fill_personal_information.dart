import 'package:flutter/material.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/ui/home/widget/banner_video_view.dart';
import 'package:pif_flutter/ui/on_boarding/fill_information/widget/personal_information.dart';
import 'package:video_player/video_player.dart';

class FillPersonalInformation extends StatefulWidget {
  const FillPersonalInformation({
    required this.userName,
    super.key,
  });

  final String userName;

  @override
  State<FillPersonalInformation> createState() => _FillPersonalInformationState();
}

class _FillPersonalInformationState extends State<FillPersonalInformation> with TickerProviderStateMixin {
  late AnimationController animation;
  late AnimationController slideAnim;
  late AnimationController fadeAnim;
  VideoPlayerController? videoPlayerController;

  bool showBottomButton = false;

  @override
  void initState() {
    videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
      ),
    );
    slideAnim = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    );
    animation = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    fadeAnim = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    Future.delayed(const Duration(milliseconds: 1000), () {
      slideAnim.forward();
    });
    Future.delayed(const Duration(milliseconds: 2000), () {
      animation.forward();
    });
    Future.delayed(const Duration(milliseconds: 2500), () {
      fadeAnim.forward();
    });
    super.initState();
  }

  @override
  void dispose() {
    animation.dispose();
    slideAnim.dispose();
    fadeAnim.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        SlideTransition(
          position: Tween(
            begin: const Offset(0, 6),
            end: const Offset(-0.25, 0.3),
          ).animate(
            CurvedAnimation(parent: slideAnim, curve: Curves.easeInOut),
          ),
          child: Center(
            child: Text(
              '${S.current.hi}${widget.userName}!',
              style: Style.commonTextStyle(
                color: dayTextColor,
                fontSize: 32.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        SlideTransition(
          position: Tween(
            begin: const Offset(-5, 0),
            end: const Offset(0, 0.7),
          ).animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.easeInToLinear,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Text(
              S.current.thrilledToHaveYouOnboard,
              style: Style.commonTextStyle(
                color: hintColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),
              maxLines: 4,
            ),
          ),
        ),
        SlideTransition(
          position: Tween(
            begin: const Offset(-5, 0),
            end: const Offset(0, 0.05),
          ).animate(
            CurvedAnimation(parent: fadeAnim, curve: Curves.easeInOut),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 40.h),
                SizedBox(
                  height: 200.h,
                  width: double.infinity,
                  child: BannerVideoView(
                    videoUrl:
                        'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4',
                    videoPlayerController: videoPlayerController,
                  ),
                ).visibility(
                  visible: videoPlayerController != null,
                ),
                const PersonalInformation(),
                SizedBox(height: 30.h),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
