import 'package:csean_mobile/domain/enums/enum.dart';

class AuthorCardModel {
  String get fullName => '$firstName $lastName';

  final AccountType type;
  final String firstName;
  final String lastName;
  final String email;

  AuthorCardModel({
    required this.type,
    required this.firstName,
    required this.lastName,
    required this.email,
  });
}