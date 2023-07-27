import 'dart:io';

import 'package:bluetooth_enable_fork/bluetooth_enable_fork.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart' as location;
import 'package:permission_handler/permission_handler.dart';
import 'package:pif_flutter/ui/booking/model/day_header_model.dart';
import 'package:url_launcher/url_launcher.dart';

class CommonUtils {
  static DateTime? _lastToastTime;

  static void showToast({required String message}) {
    if (_lastToastTime == null || DateTime.now().difference(_lastToastTime!) > const Duration(seconds: 1, milliseconds: 200)) {
      _lastToastTime = DateTime.now();
      Fluttertoast.showToast(msg: message, toastLength: Toast.LENGTH_LONG);
    }
  }

  static List<DayHeaderModel> getNextSevenDays() {
    final daysList = <DayHeaderModel>[];
    final today = DateTime.now();
    final formatter = DateFormat('EEEE');

    daysList.add(
      DayHeaderModel(
        dayDate: today.day.toString(),
        dayName: 'Today',
        isSelected: true,
        isToday: true,
        dateTime: today,
      ),
    );
    for (var i = 1; i < 7; i++) {
      final dayDate = today.add(Duration(days: i));
      final dayName = formatter.format(dayDate).substring(0, 1);
      daysList.add(
        DayHeaderModel(
          dayDate: dayDate.day.toString(),
          dayName: dayName,
          isSelected: false,
          dateTime: dayDate,
        ),
      );
    }
    return daysList;
  }

  static List<DayHeaderModel> getNextThirtyDays() {
    final daysList = <DayHeaderModel>[];
    final today = DateTime.now();
    final formatter = DateFormat('EEEE');

    daysList.add(
      DayHeaderModel(
        dayDate: today.day.toString(),
        dayName: 'Today',
        isSelected: true,
        isToday: true,
        dateTime: today,
      ),
    );
    for (var i = 1; i < 30; i++) {
      final dayDate = today.add(Duration(days: i));
      final dayName = formatter.format(dayDate).substring(0, 1);
      daysList.add(
        DayHeaderModel(
          dayDate: dayDate.day.toString(),
          dayName: dayName,
          isSelected: false,
          dateTime: dayDate,
        ),
      );
    }
    return daysList;
  }

  static Future<void> enableBluetoothAsync() async {
    if (Platform.isAndroid) {
      final statuses = await [
        Permission.bluetooth,
        Permission.bluetoothConnect,
        Permission.bluetoothScan,
      ].request();

      if (statuses.entries.every((element) => element.value.isGranted)) {
        await BluetoothEnable.enableBluetooth;
      }
    } else {
      var status = await Permission.bluetooth.status;

      if (!status.isGranted) {
        status = await Permission.bluetooth.request();
      }

      if (status.isGranted) {
        await BluetoothEnable.enableBluetooth;
      }
    }
  }

  static Future<void> openUrl(Uri uri) async {
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<void> checkPermission() async {
    // Check and request Bluetooth permission.
    await enableBluetoothAsync();

    // Request  Location (GPS) permission.
    var permissionGranted = await location.Location.instance.hasPermission();
    if (permissionGranted == location.PermissionStatus.denied) {
      permissionGranted = await location.Location.instance.requestPermission();
      if (permissionGranted != location.PermissionStatus.granted) {
        return;
      }
    }

    // Enable  location permission
    var locationStatus = await location.Location.instance.serviceEnabled();
    if (!locationStatus) {
      locationStatus = await location.Location.instance.requestService();
      if (!locationStatus) {
        return;
      }
    }

    // Check and request Motion (Accelerometer) permission.
    final motionStatus = await Permission.sensors.status;
    if (!motionStatus.isGranted) {
      await Permission.sensors.request();
    } else if (motionStatus.isDenied || motionStatus.isPermanentlyDenied) {
      await Permission.sensors.request();
    }
  }
}
