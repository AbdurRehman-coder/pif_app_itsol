import 'package:dixels_sdk/features/commerce/support/model/support_ticket_model.dart';
import 'package:flutter/material.dart';
import 'package:pif_flutter/common/index.dart';

extension TicketStatusExtension on TicketPriority {
  String get getTicketStatusName {
    switch (key) {
      case 'pending':
        return 'Pending';
      case 'inProgress':
        return 'In Progress';
      case 'closed':
        return 'Closed';
    }
    return 'Closed';
  }

  Color get getTicketStatusColor {
    switch (key) {
      case 'pending':
        return pendingStatusColor;
      case 'inProgress':
        return primaryColor;
      case 'closed':
        return darkBorderColor;
    }
    return darkBorderColor;
  }
}
