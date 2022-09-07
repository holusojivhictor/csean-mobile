import 'package:csean_mobile/domain/enums/enum.dart';

class UserAccountCardModel {
  final int id;
  final AccountType type;
  final String firstName;
  final String lastName;
  final String fullName;
  final String email;
  final String? phone;
  final int status;
  final bool subscription;
  final String photoUrl;
  final MembershipType membershipType;
  final GenderType gender;

  UserAccountCardModel({
    required this.id,
    required this.type,
    required this.firstName,
    required this.lastName,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.status,
    required this.subscription,
    required this.photoUrl,
    required this.membershipType,
    required this.gender,
  });
}