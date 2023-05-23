class FilterModel {
  FilterModel({
    required this.selectedDates,
    required this.startTime,
    required this.endTime,
    required this.capacity,
  });

  List<DateTime> selectedDates;
  DateTime startTime;
  DateTime endTime;
  String capacity;
}
