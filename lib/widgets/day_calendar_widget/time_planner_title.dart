import 'package:flutter/material.dart';
import 'package:pif_flutter/widgets/day_calendar_widget/time_planner_config.dart';

/// Title widget for time planner
class TimePlannerTitle extends StatelessWidget {
  /// Title widget for time planner
  const TimePlannerTitle({
    required this.title,
    super.key,
    this.date,
    this.titleStyle,
    this.dateStyle,
  });

  /// Title of each day, typically is name of the day for example sunday
  ///
  /// but you can set any things here
  final String title;

  /// Text style for title
  final TextStyle? titleStyle;

  /// Date of each day like 03/21/2021 but you can leave it empty or write other things
  final String? date;

  /// Text style for date text
  final TextStyle? dateStyle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: TimePlannerConfig.cellWidth!.toDouble(),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              title,
              style: titleStyle ?? const TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              date ?? '',
              style: dateStyle ?? const TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
