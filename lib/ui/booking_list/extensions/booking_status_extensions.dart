import 'package:flutter/material.dart';
import 'package:pif_flutter/generated/l10n.dart';
import 'package:pif_flutter/ui/booking_list/model/booking_list_model.dart';
import 'package:pif_flutter/utils/colors.dart';

extension BookingStatusExt on BookingStatusEnum {
  Color? get getStatusTextColor {
    final data = {
      BookingStatusEnum.upcoming: upcomingStatusColor,
      BookingStatusEnum.history: historyStatusColor,
      BookingStatusEnum.pendingApproval: pendingStatusColor
    };
    return data[this] ?? pendingStatusColor;
  }

  Color? get getStatusBgColor {
    final data = {
      BookingStatusEnum.upcoming: upcomingBgColor,
      BookingStatusEnum.history: historyBgColor,
      BookingStatusEnum.pendingApproval: pendingBgColor
    };
    return data[this] ?? pendingBgColor;
  }

  String? get getStatusText {
    final data = {
      BookingStatusEnum.upcoming: S.current.upComing,
      BookingStatusEnum.history: S.current.history,
      BookingStatusEnum.pendingApproval: S.current.pendingStatus
    };
    return data[this] ?? '';
  }
}
