import 'package:pif_flutter/common/index.dart';

extension AmenitiesExtension on String {
  String get getAmenities {
    switch (this) {
      case 'games':
        return Assets.gamePad;
      case 'screencast':
        return Assets.screencast;
      case 'tV':
        return Assets.tv;
      case 'wifi':
        return Assets.wiFi;
      case 'wirelessCharging':
        return Assets.wirelessCharge;
      default:
        return Assets.tv;
    }
  }
}
