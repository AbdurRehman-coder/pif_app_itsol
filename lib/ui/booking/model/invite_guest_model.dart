class InviteGuestModel {
  InviteGuestModel({required this.firstName, this.lastName, this.email});

  String? firstName;
  String? lastName;
  String? email;

  String? get fullName => '$firstName ${lastName!}';
}
