import 'package:hive_flutter/hive_flutter.dart';
import 'package:pif_flutter/ui/drinks/model/order_request_model.dart';

void registerHiveAdapters() {
  Hive
    ..registerAdapter(OrderRequestAdapter()) //1
    ..registerAdapter(OrderItemAdapter()); //2
}
