import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/widget/custom_lottie_widget.dart';
import 'package:video_player/video_player.dart';

class BannerVideoView extends StatefulWidget {
  const BannerVideoView({
    required this.videoUrl,
    this.onVideoFinish,
    this.hideChangeAudio = false,
    super.key,
  });

  final String videoUrl;
  final bool hideChangeAudio;
  final void Function(bool)? onVideoFinish;

  @override
  State<BannerVideoView> createState() => _BannerVideoViewState();
}

class _BannerVideoViewState extends State<BannerVideoView> {
  late VideoPlayerController videoController;
  bool videoMute = false;
  bool isError = false;
  @override
  void initState() {
    super.initState();
    videoController = VideoPlayerController.networkUrl(
      Uri.parse(
        widget.videoUrl,
      ),
    );
    videoController.initialize().then((value) {
      setState(() {
        videoController.play();
        videoController.setVolume(0);
        videoController.setLooping(true);
        videoMute = true;
      });
    }).catchError((error) {
      setState(() {
        isError = true;
      });
    });
    videoController.addListener(() {
      Future.delayed(
        const Duration(seconds: 3),
        () {
          widget.onVideoFinish?.call(!videoController.value.isPlaying);
        },
      );
    });
  }

  void updateVolume() {
    videoMute = !videoMute;
    if (videoMute) {
      videoController.setVolume(0.0);
    } else {
      videoController.setVolume(0.4);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FocusDetector(
      onFocusLost: () {
        if (videoController.value.isPlaying) {
          videoController.pause();
        }
      },
      onFocusGained: () {
        videoController.play();
      },
      child: ClipRRect(
        borderRadius: !widget.hideChangeAudio
            ? BorderRadius.circular(24.r)
            : BorderRadius.zero,
        child: Stack(
          children: [
            if (isError) ...[
              Center(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: grayD1,
                  ),
                  child: const CustomLottieWidget(
                    lottieUrl: Assets.loaderLottie,
                    isAssets: true,
                  ),
                ),
              )
            ] else ...[
              InkWell(
                onTap: !widget.hideChangeAudio ? updateVolume : null,
                child: VideoPlayer(
                  videoController,
                ),
              ),
            ],
            if (!widget.hideChangeAudio) ...[
              Positioned(
                bottom: 10.h,
                right: 10.w,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(
                        Assets.backgroundSound,
                      ),
                    ),
                  ),
                  child: Icon(
                    videoMute ? Icons.volume_off : Icons.volume_up_outlined,
                    color: blackIcon,
                    size: 18,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    videoController.pause();
    videoController.dispose();
  }
}
