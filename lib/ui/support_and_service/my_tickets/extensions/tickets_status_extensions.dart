import 'package:flutter/material.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/ui/support_and_service/my_tickets/model/tiicket_model.dart';

extension TicketStatusExtension on TicketStatusEnum {
  String get getTicketStatusName {
    switch (this) {
      case TicketStatusEnum.Pending:
        return 'Pending';
      case TicketStatusEnum.InProgress:
        return 'In Progress';
      case TicketStatusEnum.Closed:
        return 'Closed';
    }
  }

  Color get getTicketStatusColor {
    switch (this) {
      case TicketStatusEnum.Pending:
        return pendingStatusColor;
      case TicketStatusEnum.InProgress:
        return primaryColor;
      case TicketStatusEnum.Closed:
        return darkBorderColor;
    }
  }
}
