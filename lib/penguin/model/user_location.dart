import 'package:dixels_sdk/common/typedefs.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_location.g.dart';

@JsonSerializable()
@HiveType(typeId: 3, adapterName: 'UserLocationAdapter')
class UserLocation {
  UserLocation({
    required this.floorId,
    required this.xPos,
    required this.yPos,
    required this.edgeId,
  });

  factory UserLocation.fromJson(JSON json) => _$UserLocationFromJson(json);

  JSON toJson() => _$UserLocationToJson(this);

  @HiveField(0)
  String xPos;

  @HiveField(1)
  String yPos;

  @HiveField(2)
  String floorId;

  @HiveField(3)
  String edgeId;
}
