part of awesome_calendar;

class DefaultDayTile extends StatelessWidget {
  const DefaultDayTile({
    required this.date,
    this.onTap,
    this.currentDayBorderColor,
    this.selectedDayColor,
    this.selectedDateCount = 0,
    this.selectedDateList,
  });

  /// The date to show
  final DateTime date;

  /// Function to call when the day is clicked
  final void Function(DateTime datetime)? onTap;

  /// Background color of the day when it is selected
  final Color? selectedDayColor;

  /// Border color of the current day (DateTime.now())
  final Color? currentDayBorderColor;

  final int selectedDateCount;

  final List<DateTime>? selectedDateList;

  @override
  Widget build(BuildContext context) {
    final bool isToday = CalendarHelper.isToday(date);

    final bool daySelected = AwesomeCalendar.of(context)!.isDateSelected(date);

    BoxDecoration? boxDecoration;
    if (daySelected) {
      boxDecoration = BoxDecoration(
        color: selectedDayColor ?? Theme.of(context).colorScheme.secondary,
        shape: BoxShape.circle,
      );
    } else if (isToday) {
      boxDecoration = BoxDecoration(
        border: Border.all(
          color: currentDayBorderColor ?? Theme.of(context).colorScheme.secondary,
          width: 1.0,
        ),
        shape: BoxShape.circle,
      );
    }

    return Expanded(
      child: GestureDetector(
        onTap: () {
          final length = selectedDateList?.length ?? 0;
          final isContainData = selectedDateList?.contains(date.add(const Duration(hours: 12)));
          (date.weekday == DateTime.friday || date.weekday == DateTime.saturday || length >= 10)
              ? isContainData!
                  ? handleTap(context)
                  : null
              : handleTap(context);
        },
        behavior: HitTestBehavior.translucent,
        child: Container(
          height: 40.0,
          decoration: boxDecoration,
          child: Center(
            child: Text(
              '${date.day}',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: (date.weekday == DateTime.friday || date.weekday == DateTime.saturday)
                    ? const Color.fromRGBO(227, 222, 223, 1)
                    : daySelected
                        ? Colors.white
                        : const Color.fromRGBO(68, 64, 65, 1),
                fontSize: 14,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void handleTap(BuildContext context) {
    final DateTime day = DateTime(date.year, date.month, date.day, 12, 00);
    if (onTap != null) {
      onTap!(day);
    }

    AwesomeCalendar.of(context)!.setSelectedDate(day);
    AwesomeCalendar.of(context)!.setCurrentDate(day);
  }
}
