import 'package:csean_mobile/domain/models/model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'forum_data_file.freezed.dart';
part 'forum_data_file.g.dart';

@freezed
class ForumDataFile with _$ForumDataFile {

  factory ForumDataFile({
    required List<ForumFileModel> data,
  }) = _ForumDataFile;

  ForumDataFile._();

  factory ForumDataFile.fromJson(Map<String, dynamic> json) => _$ForumDataFileFromJson(json);
}