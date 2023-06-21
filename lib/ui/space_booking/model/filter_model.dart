import 'package:dixels_sdk/dixels_sdk.dart';

class FilterModel {
  FilterModel({
    required this.selectedDates,
    required this.startTime,
    required this.endTime,
    required this.capacity,
    required this.selectedFloors,
  });

  List<DateTime> selectedDates;
  DateTime? startTime;
  DateTime? endTime;
  String capacity;
  List<FloorModel?> selectedFloors;
}
