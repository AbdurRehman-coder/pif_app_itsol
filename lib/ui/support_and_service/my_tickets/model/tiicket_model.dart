class TicketModel {
  TicketModel({
    required this.ticketDescription,
    required this.ticketStatus,
    required this.ticketStart,
    required this.countMessage,
    required this.attachment,
  });

  final String ticketDescription;
  final TicketStatusEnum ticketStatus;
  final DateTime ticketStart;
  final int countMessage;
  final String attachment;
}

enum TicketStatusEnum {
  inProgress(),
  pending,
  closed,
}
