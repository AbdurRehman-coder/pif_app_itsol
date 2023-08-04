class BookingListModel {
  BookingListModel({
    this.status,
    this.bookingTitle,
    this.spaceName,
    this.spaceImage,
    this.timeRemaining,
    this.timeString,
    this.repeatedDates,
  });

  BookingStatusEnum? status;
  String? bookingTitle;
  String? spaceName;
  String? spaceImage;
  String? timeRemaining;
  String? timeString;
  String? repeatedDates;
}

enum BookingStatusEnum {
  pendingApproval,
  upcoming,
  history,
}
