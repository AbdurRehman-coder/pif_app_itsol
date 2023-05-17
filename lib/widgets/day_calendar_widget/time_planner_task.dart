import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pif_flutter/helpers/assets.dart';
import 'package:pif_flutter/widgets/day_calendar_widget/time_planner_config.dart';
import 'package:pif_flutter/widgets/day_calendar_widget/time_planner_date_time.dart';

/// Widget that show on time planner as the tasks
class TimePlannerTask extends StatelessWidget {
  /// Widget that show on time planner as the tasks
  const TimePlannerTask({
    required this.minutesDuration,
    required this.dateTime,
    super.key,
    this.daysDuration,
    this.color,
    this.onTap,
    this.child,
    this.leftSpace,
    this.widthTask,
    this.isBlocked,
  });

  // To Indicate slot is blocked
  final bool? isBlocked;

  /// Minutes duration of task or object
  final int minutesDuration;

  /// Days duration of task or object, default is 1
  final int? daysDuration;

  /// When this task will be happen
  final TimePlannerDateTime dateTime;

  /// Background color of task
  final Color? color;

  /// This will be happen when user tap on task, for example show a dialog or navigate to other page
  final Function? onTap;

  /// Show this child on the task
  ///
  /// Typically an [Text].
  final Widget? child;

  /// parameter to set space from left, to set it: config.cellWidth! * dateTime.day.toDouble()
  final double? leftSpace;

  /// parameter to set width of task, to set it: (config.cellWidth!.toDouble() * (daysDuration ?? 1)) -config.horizontalTaskPadding!
  final double? widthTask;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: ((TimePlannerConfig.cellHeight! * (dateTime.hour - TimePlannerConfig.startHour)) +
              ((dateTime.minutes * TimePlannerConfig.cellHeight!) / 60))
          .toDouble(),
      left: leftSpace,
      child: SizedBox(
        width: widthTask,
        child: Padding(
          padding: EdgeInsets.only(left: TimePlannerConfig.horizontalTaskPadding!.toDouble()),
          child: (isBlocked == true)
              ? SvgPicture.asset(
                  Assets.bookingBlockedBg,
                  width: MediaQuery.of(context).size.width - 120,
                  height: (minutesDuration.toDouble() * TimePlannerConfig.cellHeight!) / 60,
                )
              : InkWell(
                  onTap: onTap as void Function()? ?? () {},
                  child: Container(
                    height: (minutesDuration.toDouble() * TimePlannerConfig.cellHeight!) / 60,
                    //60 minutes
                    width: MediaQuery.of(context).size.width - 120,
                    padding: EdgeInsets.symmetric(horizontal: 17.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: color ?? Theme.of(context).primaryColor,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: child,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
