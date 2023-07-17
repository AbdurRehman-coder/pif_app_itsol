import 'dart:io';

import 'package:face_camera/face_camera.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/ui/home/widget/banner_video_view.dart';
import 'package:pif_flutter/ui/on_boarding/fill_information/provider/fill_information_provider.dart';
import 'package:pif_flutter/ui/on_boarding/widget/tile_card.dart';
import 'package:video_player/video_player.dart';

class ScanFace extends ConsumerStatefulWidget {
  const ScanFace({super.key});

  @override
  ConsumerState createState() => _ScanFaceState();
}

class _ScanFaceState extends ConsumerState<ScanFace> {
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
    final provider = ref.watch(fillInformationProvider);
    final notifier = ref.read(fillInformationProvider.notifier);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Column(
        children: [
          TileCard(
            title: S.current.faceID,
            description: S.current.useYourFaceIDAsyYouAccessPassToCoBuilder,
          ),
          SizedBox(height: 20.h),
          if (provider.scanFace == null) ...[
            Expanded(
              flex: 2,
              child: SmartFaceCamera(
                autoCapture: true,
                defaultCameraLens: CameraLens.front,
                imageResolution: ImageResolution.low,
                showCameraLensControl: false,
                showCaptureControl: false,
                showFlashControl: false,
                onCapture: (File? image) => image != null
                    ? notifier.selectImageFace(imageSelected: image)
                    : null,
              ),
            )
          ] else ...[
            Expanded(
              flex: 2,
              child: Image.file(
                provider.scanFace!,
                fit: BoxFit.cover,
              ),
            ),
          ],
          const Expanded(child: SizedBox()),
        ],
      ),
    );
  }
}
