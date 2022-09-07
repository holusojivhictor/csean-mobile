import 'package:csean_mobile/domain/enums/enum.dart';
import 'package:csean_mobile/presentation/profile_edit/widgets/edit_form.dart';
import 'package:flutter/material.dart';

class BottomEditLayout extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String emailAddress;
  final String companyName;
  final String occupation;
  final String jobTitle;
  final String dateOfBirth;
  final String phoneNumber;
  final String workAddress;
  final String workCity;
  final String workCountry;
  final GenderType gender;
  final MembershipType membershipType;
  final bool update;

  const BottomEditLayout({
    Key? key,
    required this.firstName,
    required this.lastName,
    required this.emailAddress,
    required this.companyName,
    required this.occupation,
    required this.jobTitle,
    required this.dateOfBirth,
    required this.phoneNumber,
    required this.workAddress,
    required this.workCity,
    required this.workCountry,
    required this.gender,
    required this.membershipType,
    required this.update,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        EditForm(
          firstName: firstName,
          lastName: lastName,
          companyName: companyName,
          occupation: occupation,
          jobTitle: jobTitle,
          dateOfBirth: dateOfBirth,
          phoneNumber: phoneNumber,
          workAddress: workAddress,
          workCity: workCity,
          workCountry: workCountry,
          gender: gender,
          membershipType: membershipType,
          update: update,
        ),
      ],
    );
  }
}
