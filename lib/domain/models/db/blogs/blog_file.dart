import 'package:freezed_annotation/freezed_annotation.dart';

part 'blog_file.freezed.dart';
part 'blog_file.g.dart';

@freezed
class BlogFile with _$BlogFile {

  factory BlogFile({
    required Map<String, dynamic> blogs,
  }) = _BlogFile;

  BlogFile._();

  factory BlogFile.fromJson(Map<String, dynamic> json) => _$BlogFileFromJson(json);
}