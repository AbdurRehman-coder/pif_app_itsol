class InviteVisitorModel {
  InviteVisitorModel(this.firstName,
      this.lastName,
      this.email,
      this.status, {
        this.isSelected = false,
      });

  String? firstName;
  String? lastName;
  String? email;
  String? status;
  bool isSelected;

  String get name => '${firstName!} ${lastName!}';

  String get shortName =>
      firstName!.substring(0, 1) + lastName!.substring(0, 1);
}
