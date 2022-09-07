import 'package:csean_mobile/domain/models/model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'topic_file.freezed.dart';
part 'topic_file.g.dart';

@freezed
class TopicFile with _$TopicFile {

  factory TopicFile({
    required List<TopicFileModel> topics,
  }) = _TopicFile;

  TopicFile._();

  factory TopicFile.fromJson(Map<String, dynamic> json) => _$TopicFileFromJson(json);
}