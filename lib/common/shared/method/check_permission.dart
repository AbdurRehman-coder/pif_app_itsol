import 'package:permission_handler/permission_handler.dart';

class CheckPermission {
  static Future<void> checkCameraPermission() async {
    const cameraPermission = Permission.camera;
    if (await cameraPermission.status.isDenied) {
      await cameraPermission.request();
    }
  }
}
