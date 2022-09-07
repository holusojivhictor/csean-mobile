// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'forum_file_model.freezed.dart';
part 'forum_file_model.g.dart';

@freezed
class ForumFileModel with _$ForumFileModel {
  factory ForumFileModel({
    required int id,
    required String name,
    String? description,
    @JsonKey(name: 'chapter_id') int? chapterId,
    required int privacy,
    required int isArchive,
  }) = _ForumFileModel;

  ForumFileModel._();

  factory ForumFileModel.fromJson(Map<String, dynamic> json) => _$ForumFileModelFromJson(json);
}