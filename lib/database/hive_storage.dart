import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

class HiveStorage {
  HiveStorage._();

  static const String encryptionBoxKey = 'HiveEncryptionKey';
  static late FlutterSecureStorage _secureStorage;
  static late Box<dynamic> _storageBox;

  static Future<HiveStorage> getInstance({
    required String boxName,
    VoidCallback? registerAdapters,
  }) async {
    WidgetsFlutterBinding.ensureInitialized();

    _secureStorage = const FlutterSecureStorage(
      aOptions: AndroidOptions(encryptedSharedPreferences: true),
    );

    final encryptionCipher = await _encryptionKey;
    final dir = await getApplicationSupportDirectory();
    Hive.init(dir.path);

    registerAdapters?.call();
    _storageBox = await Hive.openBox(boxName, encryptionCipher: encryptionCipher);

    return HiveStorage._();
  }

  static Future<HiveAesCipher> get _encryptionKey async {
    late Uint8List encryptionKey;
    final keyString = await _secureStorage.read(key: encryptionBoxKey);

    if (keyString == null) {
      final key = Hive.generateSecureKey();
      await _secureStorage.write(key: encryptionBoxKey, value: base64UrlEncode(key));
      encryptionKey = Uint8List.fromList(key);
    } else {
      encryptionKey = base64Url.decode(keyString);
    }
    return HiveAesCipher(encryptionKey);
  }

  T? get<T>({required String key, T? defaultValue}) {
    return _storageBox.get(key, defaultValue: defaultValue) as T?;
  }

  List<dynamic> getList({required String key, List<dynamic> defaultValue = const []}) {
    try {
      final json = _storageBox.get(key, defaultValue: '') as String;
      if (json.isEmpty) {
        return defaultValue;
      }

      return jsonDecode(json) as List<dynamic>;
    } catch (_) {
      return defaultValue;
    }
  }

  Future<void> put<T>({required String key, required T value}) async {
    return _storageBox.put(key, value);
  }

  Future<void> putList<T>({required String key, required List<T> value}) async {
    final data = jsonEncode(value);
    return _storageBox.put(key, data);
  }

  Future<void> putAll({required Map<String, dynamic> entries}) async {
    return _storageBox.putAll(entries);
  }

  Future<void> delete({required String key}) async {
    return _storageBox.delete(key);
  }

  Future<int> clear() async {
    return _storageBox.clear();
  }

  Future<void> close() async {
    await _storageBox.close();
  }
}
