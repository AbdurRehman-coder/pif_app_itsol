part of awesome_calendar;

class AwesomeCalendarPage extends StatelessWidget {
  const AwesomeCalendarPage({
    required this.pageStartDate,
    required this.pageEndDate,
    required this.weekdayLabels,
    required this.dayTileBuilder,
    this.onTap,
  });

  /// The maximum number of rows that we can have on a month
  static const int maxRowsCount = 6;

  /// The start date of the month to show
  final DateTime pageStartDate;

  /// The end date of the month to show
  final DateTime pageEndDate;

  /// The weekdays widget to show above the calendar
  final Widget weekdayLabels;

  /// The builder to create a day widget
  final DayTileBuilder dayTileBuilder;

  /// The function when the user clicks on a day
  final void Function(DateTime datetime)? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: buildRows(context),
      mainAxisSize: MainAxisSize.min,
    );
  }

  List<Widget> buildRows(BuildContext context) {
    int startDayOffset = pageStartDate.weekday - DateTime.monday;
    final List<Widget> rows = <Widget>[];
    rows.add(monthNameView());
    rows.add(const SizedBox(
      height: 20,
    ));
    rows.add(weekdayLabels);
    rows.add(const SizedBox(
      height: 10,
    ));

    if (pageStartDate.weekday == DateTime.sunday) {
      startDayOffset = 0;
    }
    // First week
    final DateTime rowLastDayDate = CalendarHelper.addDaysToDate(pageStartDate, 6 - startDayOffset);
    rows.add(
      Row(
        children: buildCalendarFirstWeekRow(context, pageStartDate, rowLastDayDate),
      ),
    );

    // Each row is a week
    for (int i = 1; i < maxRowsCount; i++) {
      DateTime rowFirstDayDate = CalendarHelper.addDaysToDate(pageStartDate, (7 * i - startDayOffset));

      rowFirstDayDate = rowFirstDayDate.subtract(const Duration(days: 1));
      if (rowFirstDayDate.isAfter(pageEndDate)) {
        /// The entire page is done
        break;
      }

      DateTime rowLastDayDate = CalendarHelper.addDaysToDate(rowFirstDayDate, 7);
      if (rowLastDayDate.isAfter(pageEndDate)) {
        rowLastDayDate = pageEndDate;
      }

      rows.add(
        Row(
          children: buildCalendarRow(context, rowFirstDayDate, rowLastDayDate, isSecondWeek: true),
        ),
      );
    }
    return rows;
  }

  /// Create one line of days (a week)
  List<Widget> buildCalendarRow(BuildContext context, DateTime rowStartDate, DateTime rowEndDate,
      {bool isSecondWeek = false}) {
    final List<Widget> items = <Widget>[];

    DateTime currentDate = rowStartDate;
    int rowStartWeekDay = rowStartDate.weekday;
    int rowEndWeekDay = rowEndDate.weekday;

    if (rowStartWeekDay == 6) {
      rowStartWeekDay = 1;
      currentDate = currentDate.add(const Duration(days: 1));
    } else {
      rowStartWeekDay = 1;
    }

    if (rowEndDate == rowStartDate) {
      rowEndWeekDay = 0;
    }

    for (int i = 0; i < 7; i++) {
      if (i + 1 >= rowStartWeekDay && i <= rowEndWeekDay) {
        final Widget dayTile = dayTileBuilder.build(context, currentDate, onTap);
        items.add(dayTile);
        currentDate = currentDate.add(const Duration(days: 1));
      } else {
        // Adds empty spaces at the begining and end of the page if necessary
        items.add(
          const Expanded(
            child: Text(''),
          ),
        );
      }
    }

    return items;
  }

  /// Create first week line of days (a week)
  List<Widget> buildCalendarFirstWeekRow(BuildContext context, DateTime rowStartDate, DateTime rowEndDate) {
    final List<Widget> items = <Widget>[];

    DateTime currentDate = rowStartDate;
    int rowStartWeekDay = rowStartDate.weekday;
    int rowEndWeekDay = rowEndDate.weekday;

    if (rowStartWeekDay == 7) {
      rowStartWeekDay = 0;
      // rowEndWeekDay = 1;
    } else {
      rowStartWeekDay = rowStartWeekDay + 1;
      rowEndWeekDay = rowEndWeekDay + 1;
    }

    for (int i = 0; i < 7; i++) {
      if (i + 1 >= rowStartWeekDay && i <= rowEndWeekDay) {
        final Widget dayTile = dayTileBuilder.build(context, currentDate, onTap);
        items.add(dayTile);
        currentDate = currentDate.add(const Duration(days: 1));
      } else {
        // Adds empty spaces at the begining and end of the page if necessary
        items.add(
          const Expanded(
            child: Text(''),
          ),
        );
      }
    }

    return items;
  }

  Widget monthNameView() {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Text(
          CalendarHelper.getMonthName(pageStartDate),
          style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
