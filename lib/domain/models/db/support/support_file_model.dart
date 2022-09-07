// ignore_for_file: invalid_annotation_target

import 'package:csean_mobile/domain/enums/enum.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'support_file_model.freezed.dart';
part 'support_file_model.g.dart';

@freezed
class SupportFileModel with _$SupportFileModel {
  factory SupportFileModel({
    required int id,
    @JsonKey(name: 'user_id') required int userId,
    @JsonKey(name: 'assign_id') int? assignedUserId,
    required String ticket,
    required int stage,
    required String subject,
    required String message,
    String? reply,
    @JsonKey(name: 'created_at') required String createdAt,
    @JsonKey(name: 'file_url') required String fileUrl,
    @JsonKey(name: 'support_stage') required SupportStageType supportStage,
    required SupportParticipantModel user,
    @JsonKey(name: 'assigned') SupportParticipantModel? userAssigned,
  }) = _SupportFileModel;

  SupportFileModel._();

  factory SupportFileModel.fromJson(Map<String, dynamic> json) => _$SupportFileModelFromJson(json);
}

@freezed
class SupportParticipantModel with _$SupportParticipantModel {
  String get fullName => '$firstName $lastName';

  factory SupportParticipantModel({
    @JsonKey(name: 'firstname') required String firstName,
    @JsonKey(name: 'lastname') required String lastName,
    @JsonKey(name: 'email') required String emailAddress,
    @JsonKey(name: 'photo_url') required String photoUrl,
  }) = _SupportParticipantModel;

  SupportParticipantModel._();

  factory SupportParticipantModel.fromJson(Map<String, dynamic> json) => _$SupportParticipantModelFromJson(json);
}