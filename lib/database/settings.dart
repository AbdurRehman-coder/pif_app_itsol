import 'package:flutter/widgets.dart';
import 'package:pif_flutter/common/extensions/context_extensions.dart';
import 'package:pif_flutter/database/hive_keys.dart';
import 'package:pif_flutter/database/hive_storage.dart';
import 'package:pif_flutter/main.dart';
import 'package:pif_flutter/ui/drinks/model/order_request_model.dart';

class Settings {
  static late HiveStorage storage;

  // initialize
  static void init(BuildContext context) {
    storage = context.readProvider(hiveStorageProvider);
  }

  static OrderRequestModel? get orderRequestModel {
    return storage.get<OrderRequestModel>(key: HiveKeys.drinkRequest);
  }

  static set orderRequestModel(OrderRequestModel? value) {
    storage.put(key: HiveKeys.drinkRequest, value: value);
  }
}
