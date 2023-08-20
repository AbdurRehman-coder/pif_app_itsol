import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/ui/employee_details/provider/employee_details_provider.dart';

class UploadImageOptions extends ConsumerWidget {
  const UploadImageOptions({
    required this.ctx,
    super.key,
  });
  final BuildContext ctx;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(employeeDetailsProvider.notifier);
    const cameraPermission = Permission.camera;
    return SizedBox(
      height: 200.h,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () async {
                    await AppRouter.pop();
                      final status = await cameraPermission.request();
                    if (status.isGranted) {
                      await notifier.uploadImage(
                        ImageSource.camera,
                        ctx,
                      );
                    } else {
                      await openAppSettings();
                    }
                  },
                  child: Text(
                    'Camera',
                    style: Style.commonTextStyle(
                      color: blackColor,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(
                  width: 20.w,
                ),
                const Icon(
                  Icons.camera,
                  color: primaryColor,
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () async {
                    await AppRouter.pop();
                    await notifier.uploadImage(
                      ImageSource.gallery,
                      ctx,
                    );
                  },
                  child: Text(
                    'Gallery ',
                    style: Style.commonTextStyle(
                      color: blackColor,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(
                  width: 20.w,
                ),
                const Icon(
                  Icons.photo,
                  color: primaryColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
