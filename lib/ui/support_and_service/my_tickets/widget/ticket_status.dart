import 'package:dixels_sdk/features/commerce/support/model/support_ticket_model.dart';
import 'package:flutter/material.dart';
import 'package:pif_flutter/common/index.dart';
import 'package:pif_flutter/ui/support_and_service/my_tickets/extensions/tickets_status_extensions.dart';

class TicketStatus extends StatelessWidget {
  const TicketStatus({
    required this.ticketStatus,
    super.key,
  });

  final TicketPriority ticketStatus;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ticketStatus.getTicketStatusColor.withOpacity(0.15),
        borderRadius: BorderRadius.circular(
          19.r,
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
      child: Text(
        ticketStatus.getTicketStatusName,
        style: Style.commonTextStyle(
          color: ticketStatus.getTicketStatusColor,
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
