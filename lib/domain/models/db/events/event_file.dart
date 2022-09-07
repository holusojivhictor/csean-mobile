import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_file.freezed.dart';
part 'event_file.g.dart';

@freezed
class EventFile with _$EventFile {
  factory EventFile({
    required Map<String, dynamic> events,
  }) = _EventFile;

  EventFile._();

  factory EventFile.fromJson(Map<String, dynamic> json) => _$EventFileFromJson(json);
}