class RefereeCardModel {
  final int id;
  final int userId;
  final String fullName;
  final String occupation;
  final String email;
  final String phone;
  final String relationship;
  final int status;

  RefereeCardModel({
    required this.id,
    required this.userId,
    required this.fullName,
    required this.occupation,
    required this.email,
    required this.phone,
    required this.relationship,
    required this.status,
  });
}