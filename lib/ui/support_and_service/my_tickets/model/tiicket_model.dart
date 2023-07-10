class TicketModel {
  TicketModel({
    required this.ticketText,
    required this.ticketStatus,
    required this.ticketStart,
    required this.countMessage,
  });

  final String ticketText;
  final TicketStatusEnum ticketStatus;
  final DateTime ticketStart;
  final int countMessage;
}

enum TicketStatusEnum {
  InProgress,
  Pending,
  Closed,
}
