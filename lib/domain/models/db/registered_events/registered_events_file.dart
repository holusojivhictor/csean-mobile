import 'package:freezed_annotation/freezed_annotation.dart';

part 'registered_events_file.freezed.dart';
part 'registered_events_file.g.dart';

@freezed
class RegisteredEventsFile with _$RegisteredEventsFile {

  factory RegisteredEventsFile({
    required Map<String, dynamic> events,
  }) = _RegisteredEventsFile;

  RegisteredEventsFile._();

  factory RegisteredEventsFile.fromJson(Map<String, dynamic> json) => _$RegisteredEventsFileFromJson(json);
}