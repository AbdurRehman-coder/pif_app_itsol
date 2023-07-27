import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_request_model.g.dart';

@JsonSerializable()
@HiveType(typeId: 1, adapterName: 'OrderRequestAdapter')
class OrderRequestModel {
  OrderRequestModel({
    this.accountId,
    this.channelId,
    this.orderItems,
    this.printedNote,
    this.currencyCode,
  });

  factory OrderRequestModel.fromJson(JSON json) => _$OrderRequestModelFromJson(json);

  JSON toJson() => _$OrderRequestModelToJson(this);

  @HiveField(0)
  @JsonKey(name: 'accountId')
  int? accountId;

  @HiveField(1)
  @JsonKey(name: 'channelId')
  int? channelId;

  @HiveField(2)
  @JsonKey(name: 'orderItems')
  List<OrderItem>? orderItems;

  @HiveField(3)
  @JsonKey(name: 'printedNote')
  String? printedNote;

  @HiveField(4)
  @JsonKey(name: 'currencyCode')
  String? currencyCode;
}

@JsonSerializable()
@HiveType(typeId: 2, adapterName: 'OrderItemAdapter')
class OrderItem {
  OrderItem({
    required this.options,
    required this.quantity,
    required this.skuId,
    required this.productId,
  });

  factory OrderItem.fromJson(JSON json) => _$OrderItemFromJson(json);

  JSON toJson() => _$OrderItemToJson(this);

  @HiveField(0)
  @JsonKey(name: 'options')
  String options;

  @HiveField(1)
  @JsonKey(name: 'quantity')
  int quantity;

  @HiveField(2)
  @JsonKey(name: 'skuId')
  int skuId;

  @HiveField(3)
  @JsonKey(name: 'productId')
  int productId;
}

typedef JSON = Map<String, dynamic>;
