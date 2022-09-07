import 'package:csean_mobile/domain/models/model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'registered_events_data_file.freezed.dart';
part 'registered_events_data_file.g.dart';

@freezed
class RegisteredEventsDataFile with _$RegisteredEventsDataFile {

  factory RegisteredEventsDataFile({
    required List<RegisteredEventsModel> data,
  }) = _RegisteredEventsDataFile;

  RegisteredEventsDataFile._();

  factory RegisteredEventsDataFile.fromJson(Map<String, dynamic> json) => _$RegisteredEventsDataFileFromJson(json);
}