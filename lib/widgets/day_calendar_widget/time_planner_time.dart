import 'package:flutter/material.dart';
import 'package:pif_flutter/widgets/day_calendar_widget/time_planner_config.dart';

/// Show the hour for each row of time planner
class TimePlannerTime extends StatelessWidget {
  /// Show the hour for each row of time planner
  const TimePlannerTime({
    super.key,
    this.time,
    this.setTimeOnAxis,
  });

  /// Text it will be show as hour
  final String? time;
  final bool? setTimeOnAxis;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: TimePlannerConfig.cellHeight! - 1,
      width: 50,
      child: setTimeOnAxis!
          ? Text(
              time!,
              style: const TextStyle(color: Color.fromRGBO(99, 95, 96, 0)),
            )
          : Text(
              time!,
              textAlign: TextAlign.end,
              style: const TextStyle(
                fontSize: 10,
                color: Color.fromRGBO(99, 95, 96, 1),
                fontWeight: FontWeight.w400,
              ),
            ),
    );
  }
}
