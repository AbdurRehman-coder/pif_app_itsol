import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:video_player/video_player.dart';

class BannerVideoView extends StatefulWidget {
  const BannerVideoView({
    required this.videoUrl,
    this.videoPlayerController,
    this.onVideoFinish,
    super.key,
  });

  final String videoUrl;
  final VideoPlayerController? videoPlayerController;
  final void Function(bool)? onVideoFinish;

  @override
  State<BannerVideoView> createState() => _BannerVideoViewState();
}

class _BannerVideoViewState extends State<BannerVideoView> {
  late VideoPlayerController videoController;
  bool videoMute = false;

  @override
  void initState() {
    super.initState();
    videoController = widget.videoPlayerController ??
        VideoPlayerController.networkUrl(
          Uri.parse(
            'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
          ),
        );
    videoController.initialize().then((value) {
      setState(() {
        videoController.play();
        videoController.setVolume(0.0);
        videoMute = true;
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
    return ClipRRect(
      borderRadius: BorderRadius.circular(24.r),
      child: Stack(
        children: [
          InkWell(
            onTap: () => videoController.play(),
            child: VideoPlayer(
              widget.videoPlayerController ?? videoController,
            ),
          ),
          Positioned(
            bottom: 10.h,
            right: 10.w,
            child: InkWell(
              onTap: updateVolume,
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
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    print('4567654345678987654345678${!videoController.value.isPlaying}');

    videoController.dispose();
  }
}
