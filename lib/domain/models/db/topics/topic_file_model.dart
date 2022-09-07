// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'topic_file_model.freezed.dart';
part 'topic_file_model.g.dart';

@freezed
class TopicFileModel with _$TopicFileModel {
  factory TopicFileModel({
    required int id,
    required String name,
    @JsonKey(name: 'user_id') required int creatorId,
    @JsonKey(name: 'forum_id') required int forumId,
    @JsonKey(name: 'created_at') required String createdAt,
    String? description,
    required CreatorModel user,
  }) = _TopicFileModel;

  TopicFileModel._();

  factory TopicFileModel.fromJson(Map<String, dynamic> json) => _$TopicFileModelFromJson(json);
}

@freezed
class CreatorModel with _$CreatorModel {
  String get fullName => '$firstName $lastName';

  factory CreatorModel({
    @JsonKey(name: 'firstname') required String firstName,
    @JsonKey(name: 'lastname') required String lastName,
    @JsonKey(name: 'photo_url') required String photoUrl,
  }) = _CreatorModel;

  CreatorModel._();

  factory CreatorModel.fromJson(Map<String, dynamic> json) => _$CreatorModelFromJson(json);
}