// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_file_model.freezed.dart';
part 'message_file_model.g.dart';

@freezed
class MessageFileModel with _$MessageFileModel {
  factory MessageFileModel({
    required int id,
    @JsonKey(name: 'user_id') required int userId,
    @JsonKey(name: 'forum_topic_id') required int topicId,
    required String message,
    @JsonKey(name: 'reply_id') int? replyId,
    @JsonKey(name: 'created_at') required String createdAt,
    required SenderModel user,
    MessageFileModel? reply,
    required String time,
    @JsonKey(name: 'file_url') required String fileUrl,
  }) = _MessageFileModel;

  MessageFileModel._();

  factory MessageFileModel.fromJson(Map<String, dynamic> json) => _$MessageFileModelFromJson(json);
}

@freezed
class SenderModel with _$SenderModel {
  String get fullName => '$firstName $lastName';

  factory SenderModel({
    @JsonKey(name: 'firstname') required String firstName,
    @JsonKey(name: 'lastname') required String lastName,
    @JsonKey(name: 'photo_url') required String photoUrl,
  }) = _SenderModel;

  SenderModel._();

  factory SenderModel.fromJson(Map<String, dynamic> json) => _$SenderModelFromJson(json);
}