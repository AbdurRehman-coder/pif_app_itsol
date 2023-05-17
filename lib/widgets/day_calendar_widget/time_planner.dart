import 'package:flutter/material.dart';
import 'package:pif_flutter/widgets/day_calendar_widget/time_planner_config.dart';
import 'package:pif_flutter/widgets/day_calendar_widget/time_planner_style.dart';
import 'package:pif_flutter/widgets/day_calendar_widget/time_planner_task.dart';
import 'package:pif_flutter/widgets/day_calendar_widget/time_planner_time.dart';

/// Time planner widget
class TimePlanner extends StatefulWidget {
  /// Time planner widget
  const TimePlanner({
    required this.startHour,
    required this.endHour,
    super.key,
    this.tasks,
    this.style,
    this.use24HourFormat = false,
    this.setTimeOnAxis = false,
    this.currentTimeAnimation,
  });

  /// Time start from this, it will start from 0
  final int startHour;

  /// Time end at this hour, max value is 23
  final int endHour;

  /// List of widgets on time planner
  final List<TimePlannerTask>? tasks;

  /// Style of time planner
  final TimePlannerStyle? style;

  /// When widget loaded scroll to current time with an animation. Default is true
  final bool? currentTimeAnimation;

  /// Whether time is displayed in 24 hour format or am/pm format in the time column on the left.
  final bool use24HourFormat;

  //Whether the time is displayed on the axis of the tim or on the center of the timeblock. Default is false.
  final bool setTimeOnAxis;

  @override
  _TimePlannerState createState() => _TimePlannerState();
}

class _TimePlannerState extends State<TimePlanner> {
  final mainHorizontalController = ScrollController();
  final mainVerticalController = ScrollController();
  final dayHorizontalController = ScrollController();
  final timeVerticalController = ScrollController();
  final style = TimePlannerStyle();
  List<TimePlannerTask> tasks = [];
  bool? isAnimated = true;
  double? _yPosition = 100;

  /// check input value rules
  void _checkInputValue() {
    if (widget.startHour > widget.endHour) {
      throw FlutterError('Start hour should be lower than end hour');
    } else if (widget.startHour < 0) {
      throw FlutterError('Start hour should be larger than 0');
    } else if (widget.endHour > 24) {
      throw FlutterError('Start hour should be lower than 23');
    }
  }

  /// create local style
  void _convertToLocalStyle() {
    style.backgroundColor = widget.style?.backgroundColor;
    style.cellHeight = widget.style?.cellHeight ?? 80;
    style.cellWidth = widget.style?.cellWidth ?? 90;
    style.horizontalTaskPadding = widget.style?.horizontalTaskPadding ?? 0;
    style.borderRadius = widget.style?.borderRadius ??
        const BorderRadius.all(Radius.circular(8));
    style.dividerColor = widget.style?.dividerColor;
    style.showScrollBar = widget.style?.showScrollBar ?? false;
    style.interstitialOddColor = widget.style?.interstitialOddColor;
    style.interstitialEvenColor = widget.style?.interstitialEvenColor;
  }

  /// store input data to static values
  void _initData() {
    _checkInputValue();
    _convertToLocalStyle();
    TimePlannerConfig.horizontalTaskPadding = style.horizontalTaskPadding;
    TimePlannerConfig.cellHeight = style.cellHeight;
    TimePlannerConfig.cellWidth = style.cellWidth;
    TimePlannerConfig.totalHours =
        (widget.endHour - widget.startHour).toDouble();
    // config.totalDays = widget.headers.length;
    TimePlannerConfig.startHour = widget.startHour;
    TimePlannerConfig.use24HourFormat = widget.use24HourFormat;
    TimePlannerConfig.setTimeOnAxis = widget.setTimeOnAxis;
    TimePlannerConfig.borderRadius = style.borderRadius;
    isAnimated = widget.currentTimeAnimation;
    tasks = widget.tasks ?? [];
  }

  @override
  void initState() {
    _initData();
    super.initState();
    Future.delayed(Duration.zero).then((_) {
      final hour = DateTime.now().hour;
      if (isAnimated != null && isAnimated == true) {
        if (hour > widget.startHour) {
          final scrollOffset = (hour - widget.startHour) *
              TimePlannerConfig.cellHeight!.toDouble();
          mainVerticalController.animateTo(
            scrollOffset,
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeOutCirc,
          );
          timeVerticalController.animateTo(
            scrollOffset,
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeOutCirc,
          );
        }
      }
    });
  }

  @override
  void dispose() {
    mainHorizontalController.dispose();
    mainVerticalController.dispose();
    timeVerticalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // we need to update the tasks list in case the tasks have changed
    tasks = widget.tasks ?? [];
    mainHorizontalController.addListener(() {
      dayHorizontalController.jumpTo(mainHorizontalController.offset);
    });
    mainVerticalController.addListener(() {
      timeVerticalController.jumpTo(mainVerticalController.offset);
    });
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            controller: timeVerticalController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                //first number is start hour and second number is end hour
                for (int i = widget.startHour; i <= widget.endHour; i++)
                  Padding(
                    // we need some additional padding horizontally if we're showing in am/pm format
                    padding: EdgeInsets.symmetric(
                      horizontal: !TimePlannerConfig.use24HourFormat ? 4 : 0,
                    ),
                    child: TimePlannerTime(
                      // this returns the formatted time string based on the use24HourFormat argument.
                      time: formattedTime(i),
                      setTimeOnAxis: TimePlannerConfig.setTimeOnAxis,
                    ),
                  )
              ],
            ),
          ),
        ),
        Expanded(
          child: buildMainBody(),
        ),
      ],
    );
  }

  Widget buildMainBody() {
    return SingleChildScrollView(
      controller: mainVerticalController,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            height:
                (TimePlannerConfig.totalHours * TimePlannerConfig.cellHeight!) +
                    10,
            width: MediaQuery.of(context).size.width - 70,
            child: Stack(
              children: <Widget>[
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    for (var i = 0; i < TimePlannerConfig.totalHours; i++)
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          SizedBox(
                            height: TimePlannerConfig.cellHeight! - 1,
                          ),
                          const Divider(
                            height: 1,
                          ),
                        ],
                      )
                  ],
                ),
                // Row(
                //   mainAxisSize: MainAxisSize.min,
                //   children: <Widget>[
                //     for (var i = 0; i < config.totalDays; i++)
                //       Row(
                //         mainAxisSize: MainAxisSize.min,
                //         children: <Widget>[
                //           SizedBox(
                //             width: (config.cellWidth! - 1).toDouble(),
                //           ),
                //           Container(
                //             width: 1,
                //             height: (config.totalHours * config.cellHeight!) + config.cellHeight!,
                //             color: Colors.black12,
                //           )
                //         ],
                //       )
                //   ],
                // ),
                for (int i = 0; i < tasks.length; i++) tasks[i],
              ],
            ),
          ),
        ],
      ),
    );
  }

  String formattedTime(int hour) {
    /// this method formats the input hour into a time string
    /// modifing it as necessary based on the use24HourFormat flag .
    if (TimePlannerConfig.use24HourFormat) {
      // we use the hour as-is
      return '$hour:00';
    } else {
      // we format the time to use the am/pm scheme
      if (hour == 0) return '12:00 am';
      if (hour < 12) return '$hour:00 am';
      if (hour == 12) return '12:00 pm';
      return '${hour - 12}:00 pm';
    }
  }
}
