part of awesome_calendar;

class DefaultWeekdayLabels extends StatelessWidget {
  final DateTime sunday = DateTime(2020, 01, 12);
  final DateTime monday = DateTime(2020, 01, 06);
  final DateTime tuesday = DateTime(2020, 01, 07);
  final DateTime wednesday = DateTime(2020, 01, 08);
  final DateTime thursday = DateTime(2020, 01, 09);
  final DateTime friday = DateTime(2020, 01, 10);
  final DateTime saturday = DateTime(2020, 01, 11);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            DateFormat('E').format(sunday)[0],
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14, color: Color.fromRGBO(119, 115, 116, 1)),
          ),
        ),
        Expanded(
          child: Text(
            DateFormat('E').format(monday)[0],
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14, color: Color.fromRGBO(119, 115, 116, 1)),
          ),
        ),
        Expanded(
          child: Text(
            DateFormat('E').format(tuesday)[0],
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14, color: Color.fromRGBO(119, 115, 116, 1)),
          ),
        ),
        Expanded(
          child: Text(
            DateFormat('E').format(wednesday)[0],
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14, color: Color.fromRGBO(119, 115, 116, 1)),
          ),
        ),
        Expanded(
          child: Text(
            DateFormat('E').format(thursday)[0],
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14, color: Color.fromRGBO(119, 115, 116, 1)),
          ),
        ),
        Expanded(
          child: Text(
            DateFormat('E').format(friday)[0],
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14, color: Color.fromRGBO(119, 115, 116, 1)),
          ),
        ),
        Expanded(
          child: Text(
            DateFormat('E').format(saturday)[0],
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14, color: Color.fromRGBO(119, 115, 116, 1)),
          ),
        ),
      ],
    );
  }
}
