import 'package:flutter/material.dart';
import 'package:pif_flutter/generated/l10n.dart';
import 'package:pif_flutter/ui/booking_list/model/booking_list_model.dart';
import 'package:pif_flutter/utils/colors.dart';

extension BookingStatusExt on BookingStatusEnum {
  Color? get getStatusTextColor {
    final data = {
      BookingStatusEnum.active: activeStatusColor,
      BookingStatusEnum.expired: expireStatusColor,
      BookingStatusEnum.logged: loggedStatusColor,
      BookingStatusEnum.pendingApproval: pendingStatusColor
    };
    return data[this] ?? pendingStatusColor;
  }

  Color? get getStatusBgColor {
    final data = {
      BookingStatusEnum.active: activeBgColor,
      BookingStatusEnum.expired: expireBgColor,
      BookingStatusEnum.logged: loggedBgColor,
      BookingStatusEnum.pendingApproval: pendingBgColor
    };
    return data[this] ?? pendingBgColor;
  }

  String? get getStatusText {
    final data = {
      BookingStatusEnum.active: S.current.activeStatus,
      BookingStatusEnum.expired: S.current.expireStatus,
      BookingStatusEnum.logged: S.current.loggedStatus,
      BookingStatusEnum.pendingApproval: S.current.pendingStatus
    };
    return data[this] ?? '';
  }
}
