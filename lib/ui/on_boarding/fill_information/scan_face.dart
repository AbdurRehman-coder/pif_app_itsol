import 'dart:io';

import 'package:camera/camera.dart';
import 'package:dixels_sdk/dixels_sdk.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pif_flutter/common/extensions/context_extensions.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/main.dart';
import 'package:pif_flutter/ui/home/widget/banner_video_view.dart';
import 'package:pif_flutter/ui/on_boarding/fill_information/provider/fill_information_provider.dart';
import 'package:pif_flutter/ui/on_boarding/widget/tile_card.dart';
import 'package:video_player/video_player.dart';

class ScanFaceCamera extends StatefulWidget {
  const ScanFaceCamera({Key? key}) : super(key: key);

  @override
  State<ScanFaceCamera> createState() => _ScanFaceCameraState();
}

class _ScanFaceCameraState extends State<ScanFaceCamera> {
  VideoPlayerController? videoPlayerController;

  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final provider = ref.watch(fillInformationProvider);
        final notifier = ref.read(fillInformationProvider.notifier);
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 55.h),
                TileCard(
                  title: S.current.faceID,
                  description:
                      S.current.useYourFaceIDAsyYouAccessPassToCoBuilder,
                ),
                SizedBox(height: 20.h),
                if (!provider.isVideoFinish) ...[
                  SizedBox(
                    height: 200.h,
                    width: double.infinity,
                    child: BannerVideoView(
                      videoUrl:
                          'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4',
                      videoPlayerController: videoPlayerController,
                      onVideoFinish: notifier.onVideoScanFaceFinish,
                    ),
                  ),
                ],
                if (provider.isVideoFinish) ...[
                  if (provider.scanFace == null) ...[
                    Builder(
                      builder: (_) {
                        if (!provider.cameraController!.value.isInitialized) {
                          notifier.initializeCamera();
                        }
                        if (provider.cameraController!.value.isInitialized) {
                          return SizedBox(
                            height: context.screenHeight / 2,
                            width: double.infinity,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: AspectRatio(
                                aspectRatio: 1 / 2,
                                child: CameraPreview(
                                  provider.cameraController!,
                                ),
                              ),
                            ),
                          );
                        } else {
                          return SizedBox(
                            height: context.screenHeight / 2,
                          );
                        }
                      },
                    ),
                  ] else ...[
                    SizedBox(
                      height: context.screenHeight / 2,
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Image.file(
                          File(provider.scanFace!.path),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
