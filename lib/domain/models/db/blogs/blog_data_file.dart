import 'package:csean_mobile/domain/models/model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'blog_data_file.freezed.dart';
part 'blog_data_file.g.dart';

@freezed
class BlogDataFile with _$BlogDataFile {

  factory BlogDataFile({
    required List<BlogFileModel> data,
  }) = _BlogDataFile;

  BlogDataFile._();

  factory BlogDataFile.fromJson(Map<String, dynamic> json) => _$BlogDataFileFromJson(json);
}