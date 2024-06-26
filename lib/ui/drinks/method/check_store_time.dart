import 'package:flutter/material.dart';

bool checkStoreStatus({
  required String openTime,
  required String closedTime,
}) {
  //NOTE: Time should be as given format only
  //10:00PM
  //10:00AM

  // 01:60PM ->13:60
  //Hrs:Min
  //if AM then its ok but if PM then? 12+time (12+10=22)

  final timeNow = TimeOfDay.now();
  final openHr = openTime.substring(0, 2);
  final openMin = openTime.substring(3, 5);
  final openAmPm = openTime.substring(5).replaceAll(' ', '');
  TimeOfDay timeOpen;
  if (openAmPm == 'AM') {
    //am case
    if (openHr == '12') {
      //if 12AM then time is 00
      timeOpen = TimeOfDay(hour: 00, minute: int.parse(openMin));
    } else {
      timeOpen = TimeOfDay(hour: int.parse(openHr), minute: int.parse(openMin));
    }
  } else {
    //pm case
    if (openHr == '12') {
//if 12PM means as it is
      timeOpen = TimeOfDay(hour: int.parse(openHr), minute: int.parse(openMin));
    } else {
//add +12 to conv time to 24hr format
      timeOpen =
          TimeOfDay(hour: int.parse(openHr) + 12, minute: int.parse(openMin));
    }
  }

  final closeHr = closedTime.substring(0, 2);
  final closeMin = closedTime.substring(3, 5);
  final closeAmPm = closedTime.substring(5).replaceAll(' ', '');

  TimeOfDay timeClose;

  if (closeAmPm == 'AM') {
    //am case
    if (closeHr == '12') {
      timeClose = TimeOfDay(hour: 0, minute: int.parse(closeMin));
    } else {
      timeClose =
          TimeOfDay(hour: int.parse(closeHr), minute: int.parse(closeMin));
    }
  } else {
    //pm case
    if (closeHr == '12') {
      timeClose =
          TimeOfDay(hour: int.parse(closeHr), minute: int.parse(closeMin));
    } else {
      timeClose =
          TimeOfDay(hour: int.parse(closeHr) + 12, minute: int.parse(closeMin));
    }
  }

  var nowInMinutes = timeNow.hour * 60 + timeNow.minute;
  var openTimeInMinutes = timeOpen.hour * 60 + timeOpen.minute;
  var closeTimeInMinutes = timeClose.hour * 60 + timeClose.minute;

//handling day change ie pm to am
  if ((closeTimeInMinutes - openTimeInMinutes) < 0) {
    closeTimeInMinutes = closeTimeInMinutes + 1440;
    if (nowInMinutes >= 0 && nowInMinutes < openTimeInMinutes) {
      nowInMinutes = nowInMinutes + 1440;
    }
    if (openTimeInMinutes < nowInMinutes && nowInMinutes < closeTimeInMinutes) {
      return true;
    }
  } else if (openTimeInMinutes < nowInMinutes &&
      nowInMinutes < closeTimeInMinutes) {
    return true;
  }

  return false;
}
