import 'package:csean_mobile/domain/models/model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_data_file.freezed.dart';
part 'event_data_file.g.dart';

@freezed
class EventDataFile with _$EventDataFile {
  factory EventDataFile({
    required List<EventFileModel> data,
  }) = _EventDataFile;

  EventDataFile._();

  factory EventDataFile.fromJson(Map<String, dynamic> json) => _$EventDataFileFromJson(json);
}