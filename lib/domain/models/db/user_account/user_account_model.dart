// ignore_for_file: invalid_annotation_target

import 'package:csean_mobile/domain/assets.dart';
import 'package:csean_mobile/domain/enums/enum.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_account_model.freezed.dart';
part 'user_account_model.g.dart';

@freezed
class UserAccountModel with _$UserAccountModel {
  String get fullName => '$firstName $lastName';
  String get phoneNumber => '$phone';

  factory UserAccountModel({
    required int id,
    required AccountType type,
    @JsonKey(name: 'firstname') required String firstName,
    @JsonKey(name: 'lastname') required String lastName,
    required String email,
    String? phone,
    required int status,
    @JsonKey(name: 'subscribtion') required int subscription,
    @JsonKey(name: 'created_at') required String createdAt,
    @JsonKey(name: 'photo_url') required String photoUrl,
    required ProfileModel profile,
    required List<CertificateModel> certificates,
    required List<RefereeModel> referees,
  }) = _UserAccountModel;

  UserAccountModel._();

  factory UserAccountModel.fromJson(Map<String, dynamic> json) => _$UserAccountModelFromJson(json);
}

@freezed
class ProfileModel with _$ProfileModel {
  MembershipType get nonNullType => Assets.getMembershipType(membershipType);
  GenderType get genderType => Assets.getGenderType(gender);

  factory ProfileModel({
    required int id,
    @JsonKey(name: 'user_id') required int userId,
    @JsonKey(name: 'chapter_id') int? chapterId,
    @JsonKey(name: 'membership_type') MembershipType? membershipType,
    @JsonKey(name: 'current_occupation') String? currentOccupation,
    @JsonKey(name: 'job_title') String? jobTitle,
    @JsonKey(name: 'company_name') String? companyName,
    String? address,
    String? city,
    String? country,
    String? gender,
    String? dateOfBirth,
    required int terms,
    String? resume,
    ChapterModel? chapter,
  }) = _ProfileModel;

  ProfileModel._();

  factory ProfileModel.fromJson(Map<String, dynamic> json) => _$ProfileModelFromJson(json);
}

@freezed
class ChapterModel with _$ChapterModel {

  factory ChapterModel({
    required int id,
    required ChapterType name,
    String? description,
    required dynamic officers,
    String? extra,
  }) = _ChapterModel;

  ChapterModel._();

  factory ChapterModel.fromJson(Map<String, dynamic> json) => _$ChapterModelFromJson(json);
}

@freezed
class CertificateModel with _$CertificateModel {

  factory CertificateModel({
    required int id,
    @JsonKey(name: 'user_id') required int userId,
    @JsonKey(name: 'certificate') required String certificateUrl,
    @JsonKey(name: 'certificate_name') required String certificateName,
    @JsonKey(name: 'certification_date') required String certificationDate,
    @JsonKey(name: 'certificate_details') String? certificateDetails,
  }) = _CertificateModel;

  CertificateModel._();

  factory CertificateModel.fromJson(Map<String, dynamic> json) => _$CertificateModelFromJson(json);
}

@freezed
class RefereeModel with _$RefereeModel {

  factory RefereeModel({
    required int id,
    @JsonKey(name: 'user_id') required int userId,
    @JsonKey(name: 'full_name') required String fullName,
    required String occupation,
    required String email,
    required String phone,
    required String relationship,
    required int status,
  }) = _RefereeModel;

  RefereeModel._();

  factory RefereeModel.fromJson(Map<String, dynamic> json) => _$RefereeModelFromJson(json);
}

@freezed
class SubscriptionModel with _$SubscriptionModel {
  factory SubscriptionModel({
    required int id,
    required MembershipType name,
    required double amount,
    String? description,
    @JsonKey(name: 'grace_period') required int gracePeriod,
  }) = _SubscriptionModel;

  SubscriptionModel._();

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) => _$SubscriptionModelFromJson(json);
}