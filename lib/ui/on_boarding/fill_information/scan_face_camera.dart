import 'dart:io';
import 'dart:math' as math;

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pif_flutter/common/extensions/context_extensions.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/common/shared/method/check_permission.dart';
import 'package:pif_flutter/common/shared/widget/background_widget.dart';
import 'package:pif_flutter/common/shared/widget/banner_video_view.dart';
import 'package:pif_flutter/common/shared/widget/custom_app_bar.dart';
import 'package:pif_flutter/helpers/constants.dart';
import 'package:pif_flutter/ui/on_boarding/fill_information/provider/fill_information_provider.dart';
import 'package:pif_flutter/ui/on_boarding/fill_information/widget/bottom_button.dart';
import 'package:pif_flutter/ui/on_boarding/widget/tile_card.dart';

class ScanFaceCamera extends ConsumerStatefulWidget {
  const ScanFaceCamera({super.key});

  @override
  ConsumerState createState() => _ScanFaceCameraState();
}

class _ScanFaceCameraState extends ConsumerState<ScanFaceCamera> {
  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(fillInformationProvider);
    final notifier = ref.read(fillInformationProvider.notifier);
    return Scaffold(
      appBar: const CustomAppBar(),
      body: BackgroundWidget(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
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
                    child: Builder(
                      builder: (context) {
                        final videoUrl = Constants.baseUrl +
                            (provider.contentModel?.value?.contentFields!
                                    .where(
                                      (element) =>
                                          element.name == 'faceIDVideo',
                                    )
                                    .firstOrNull!
                                    .contentFieldValue!
                                    .document!
                                    .contentUrl ??
                                '');
                        return BannerVideoView(
                          videoUrl: videoUrl,
                        );
                      },
                    ),
                  ),
                ],
                if (provider.isVideoFinish) ...[
                  if (provider.scanFace == null) ...[
                    Builder(
                      builder: (_) {
                        CheckPermission.checkCameraPermission();

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
                                aspectRatio: provider
                                    .cameraController!.value.aspectRatio,
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
                      child: Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.rotationY(math.pi),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: AspectRatio(
                            aspectRatio: 1.2 / 3,
                            child: Image.file(
                              File(provider.scanFace!.path),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: const BottomButton(fromScanFace: true),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
