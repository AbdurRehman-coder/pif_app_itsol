class InviteVisitorModel {
  InviteVisitorModel(
    this.firstName,
    this.lastName,
    this.email, {
    required this.fromHistory,
    required this.isVisitorVerified,
  }) : isSelected = false;

  String? firstName;
  String? lastName;
  String? email;
  bool isSelected;
  bool fromHistory;
  bool isVisitorVerified;

  String get name => '${firstName!} ${lastName!}';

  String get shortName =>
      firstName!.substring(0, 1) + lastName!.substring(0, 1);
}
