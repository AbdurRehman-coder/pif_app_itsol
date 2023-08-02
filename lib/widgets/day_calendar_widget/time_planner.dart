import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:pif_flutter/helpers/assets.dart';
import 'package:pif_flutter/utils/colors.dart';
import 'package:pif_flutter/utils/styles.dart';
import 'package:pif_flutter/widgets/day_calendar_widget/time_planner_config.dart';
import 'package:pif_flutter/widgets/day_calendar_widget/time_planner_style.dart';
import 'package:pif_flutter/widgets/day_calendar_widget/time_planner_task.dart';
import 'package:pif_flutter/widgets/day_calendar_widget/time_planner_time.dart';
import 'package:pif_flutter/widgets/widget_extensions.dart';

class TimePlanner extends StatefulWidget {
  /// Time planner widget
  const TimePlanner({
    required this.startHour,
    required this.endHour,
    required this.startTime,
    required this.endTime,
    super.key,
    this.tasks,
    this.style,
    this.use24HourFormat = false,
    this.setTimeOnAxis = false,
    this.currentTimeAnimation,
  });

  //StartTime
  final DateTime? startTime;

  //EndTIme
  final DateTime? endTime;

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
  State createState() => _TimePlannerState();
}

class _TimePlannerState extends State<TimePlanner> {
  final mainVerticalController = ScrollController();
  final timeVerticalController = ScrollController();
  final style = TimePlannerStyle();
  List<TimePlannerTask> tasks = [];
  bool? isAnimated = true;
  double _yPosition = 0;
  final ScrollPhysics _scrollPhysics = const BouncingScrollPhysics();
  double _height = 60;
  String _startTimeString = '';
  String _endTimeString = '';
  String _startTimeFormat = '';
  String _endTimeFormat = '';

  // double? _previousOffset = 0;
  // late DateTime? _startTime;
  // late DateTime? _endTime;

  // bool isDragStart = true;

  /// check input value rules
  void _checkInputValue() {
    if (widget.startHour > widget.endHour) {
      throw FlutterError('Start hour should be lower than end hour');
    } else if (widget.startHour < 0) {
      throw FlutterError('Start hour should be larger than 0');
    } else if (widget.endHour > 24) {
      throw FlutterError('Start hour should be lower than 24');
    }
  }

  /// create local style
  void _convertToLocalStyle() {
    style.backgroundColor = widget.style?.backgroundColor;
    style.cellHeight = widget.style?.cellHeight ?? 80;
    style.cellWidth = widget.style?.cellWidth ?? 90;
    style.horizontalTaskPadding = widget.style?.horizontalTaskPadding ?? 0;
    style.borderRadius = widget.style?.borderRadius ?? const BorderRadius.all(Radius.circular(8));
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
    TimePlannerConfig.totalHours = (widget.endHour - widget.startHour).toDouble();
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
    Future<dynamic>.delayed(Duration.zero).then((_) {
      final hour = DateTime.now().hour;
      if (isAnimated != null && isAnimated!) {
        if (hour > widget.startHour) {
          final scrollOffset = (hour - widget.startHour) * TimePlannerConfig.cellHeight!.toDouble();
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
    mainVerticalController.dispose();
    timeVerticalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // we need to update the tasks list in case the tasks have changed
    tasks = widget.tasks ?? [];

    if (widget.startTime != null && widget.endTime != null) {
      final startTimeMinute = (widget.startTime!.hour * 60) + widget.startTime!.minute.toDouble();
      final endTimeMinute = (widget.endTime!.hour * 60) + widget.endTime!.minute.toDouble();
      _yPosition = startTimeMinute;
      final startTimeString = DateFormat('hh:mm').format(widget.startTime!);
      final endTimeString = DateFormat('hh:mm').format(widget.endTime!);

      _height = endTimeMinute - startTimeMinute; // > 300 ? 60 : endTimeMinute - startTimeMinute;

      _startTimeString = startTimeString;
      _endTimeString = endTimeString;
      _startTimeFormat = DateFormat('a').format(widget.startTime!);
      _endTimeFormat = DateFormat('a').format(widget.endTime!);
    }

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
    return Stack(
      children: [
        SingleChildScrollView(
          physics: _scrollPhysics,
          controller: mainVerticalController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: (TimePlannerConfig.totalHours * TimePlannerConfig.cellHeight!) + 10,
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
                                color: Colors.transparent,
                              ),
                            ],
                          )
                      ],
                    ),
                    for (int i = 0; i < tasks.length; i++) tasks[i],
                    Positioned(
                      left: 40,
                      top: _yPosition,
                      child: Container(
                        width: MediaQuery.of(context).size.width - 120,
                        height: _height.abs(),
                        decoration: BoxDecoration(
                          color: grayCardBg,
                          border: Border.all(color: primaryColor),
                          borderRadius: BorderRadius.circular(
                            16.r,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _startTimeString,
                              style: Style.commonTextStyle(
                                color: textColor,
                                fontSize: _height < 30 ? 12.sp : 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            Text(
                              _startTimeFormat,
                              style: Style.commonTextStyle(
                                color: hintColor,
                                fontSize: _height < 30 ? 11.sp : 14.sp,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            SvgPicture.asset(Assets.rightArrow),
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              _endTimeString,
                              style: Style.commonTextStyle(
                                color: textColor,
                                fontSize: _height < 30 ? 12.sp : 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            Text(
                              _endTimeFormat,
                              style: Style.commonTextStyle(
                                color: hintColor,
                                fontSize: _height < 30 ? 11.sp : 14.sp,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ).visibility(visible: widget.startTime != null && widget.endTime != null),
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
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
      if (hour == 24) return '12:00 am';
      return '${hour - 12}:00 pm';
    }
  }
}
