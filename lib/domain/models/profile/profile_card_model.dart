import 'package:csean_mobile/domain/enums/enum.dart';
import 'package:csean_mobile/domain/models/model.dart';

class ProfileCardModel {
  final int userId;
  final int? chapterId;
  final MembershipType? membershipType;
  final String? currentOccupation;
  final String? jobTitle;
  final String? companyName;
  final String? address;
  final String? city;
  final String? country;
  final GenderType gender;
  final String? dateOfBirth;
  final String? resume;
  final ChapterCardModel? chapter;

  ProfileCardModel({
    required this.userId,
    required this.chapterId,
    required this.membershipType,
    required this.currentOccupation,
    required this.jobTitle,
    required this.companyName,
    required this.address,
    required this.city,
    required this.country,
    required this.gender,
    required this.dateOfBirth,
    required this.resume,
    required this.chapter,
  });
}