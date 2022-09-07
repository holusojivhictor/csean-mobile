import 'package:freezed_annotation/freezed_annotation.dart';

part 'forum_file.freezed.dart';
part 'forum_file.g.dart';

@freezed
class ForumFile with _$ForumFile {

  factory ForumFile({
    required Map<String, dynamic> forums,
  }) = _ForumFile;

  ForumFile._();

  factory ForumFile.fromJson(Map<String, dynamic> json) => _$ForumFileFromJson(json);
}