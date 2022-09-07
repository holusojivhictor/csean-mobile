import 'package:csean_mobile/domain/models/model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_file.freezed.dart';
part 'message_file.g.dart';

@freezed
class MessageFile with _$MessageFile {
  factory MessageFile({
    required List<MessageFileModel> discussion,
  }) = _MessageFile;

  MessageFile._();

  factory MessageFile.fromJson(Map<String, dynamic> json) => _$MessageFileFromJson(json);
}