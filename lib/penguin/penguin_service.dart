import 'package:flutter/services.dart';

class PenguinApiService {
  static const MethodChannel _channel = MethodChannel('com.appswave.pif/penguin');

  static Future<String?> get getCurrentLocation async {
    final location = await _channel.invokeMethod('getCurrentLocation') as String?;
    return location;
  }

  static Future<bool?> get initializePenguin async {
    final result = await _channel.invokeMethod('initializePenguin') as bool?;
    return result;
  }
}
