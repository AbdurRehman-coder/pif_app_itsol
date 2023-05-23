class InviteGuestModel {
  InviteGuestModel({required this.firstName, required this.lastName, required this.email});

  String? firstName;
  String? lastName;
  String? email;

  String? get fullName => '$firstName ${lastName!}';
}
