import 'package:flutter/material.dart';
import 'package:pif_flutter/utils/colors.dart';

extension BookingStatusExt on String {
  Color get getStatusTextColor {
    switch (this) {
      case 'pending':
        return upcomingStatusColor;
      case 'history':
        return historyStatusColor;
      default:
        return pendingStatusColor;
    }
  }

  Color get getStatusBgColor {
    switch (this) {
      case 'pending':
        return upcomingBgColor;
      case 'history':
        return historyBgColor;
      default:
        return pendingBgColor;
    }
  }
}
