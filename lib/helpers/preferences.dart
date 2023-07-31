import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late final SharedPreferences instance;

  static Future<SharedPreferences> init() async => instance = await SharedPreferences.getInstance();
}

class PreferencesEnum {
  static String isFirstTimeInstall = 'isFirstTimeInstall';
}
