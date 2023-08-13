import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:table_calendar/table_calendar.dart';

class DatePickerWidget extends StatefulWidget {
  const DatePickerWidget({
    required this.onConfirm,
    required this.onCancel,
    required this.selectedDate,
    super.key,
  });

  final void Function(DateTime) onConfirm;
  final void Function() onCancel;
  final DateTime? selectedDate;

  @override
  State<DatePickerWidget> createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  DateTime? _focusedDay;
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    _selectedDay = widget.selectedDate ?? DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 2.w, right: 2.w, top: 50.h),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      height: 465.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            blurRadius: 10,
            color: grayE3,
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(
            height: 395,
            child: TableCalendar<void>(
              firstDay: DateTime.now(),
              lastDay: DateTime(DateTime.now().year + 2, DateTime.now().month, DateTime.now().day),
              focusedDay: _focusedDay!,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              availableGestures: AvailableGestures.none,
              onDaySelected: _onDaySelected,
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
              daysOfWeekStyle: const DaysOfWeekStyle(
                weekdayStyle: TextStyle(color: darkBorderColor),
                weekendStyle: TextStyle(color: darkBorderColor),
              ),
              headerStyle: HeaderStyle(
                headerPadding: EdgeInsets.only(bottom: 20.h),
                titleTextFormatter: (date, locale) {
                  return DateFormat('MMMM yyyy').format(date);
                },
                leftChevronMargin: EdgeInsets.symmetric(horizontal: 4.w),
                leftChevronPadding: EdgeInsets.all(8.r),
                leftChevronIcon: RotatedBox(
                  quarterTurns: 1,
                  child: SvgPicture.asset(
                    Assets.arrowDown,
                  ),
                ),
                rightChevronMargin: EdgeInsets.symmetric(horizontal: 4.w),
                rightChevronPadding: EdgeInsets.all(8.r),
                rightChevronIcon: RotatedBox(
                  quarterTurns: -1,
                  child: SvgPicture.asset(
                    Assets.arrowDown,
                  ),
                ),
                titleCentered: true,
                formatButtonShowsNext: false,
                formatButtonVisible: false,
              ),
              calendarStyle: const CalendarStyle(
                outsideDaysVisible: false,
                isTodayHighlighted: false,
                selectedDecoration: BoxDecoration(
                  color: primaryColor,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: widget.onCancel,
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  foregroundColor: primaryColor,
                  backgroundColor: Colors.white,
                ),
                child: Center(
                  child: Text(
                    S.of(context).cancel,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  widget.onConfirm.call(_selectedDay!);
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: primaryColor,
                ),
                child: Center(
                  child: Text(
                    S.of(context).confirm,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
    });
  }
}
