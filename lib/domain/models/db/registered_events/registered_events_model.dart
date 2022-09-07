// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'registered_events_model.freezed.dart';
part 'registered_events_model.g.dart';

@freezed
class RegisteredEventsModel with _$RegisteredEventsModel {
  factory RegisteredEventsModel({
    required int id,
    @JsonKey(name: 'user_id') required int userId,
    @JsonKey(name: 'event_id') required int eventId,
    @JsonKey(name: 'ticket') required String ticketId,
  }) = _RegisteredEventsModel;

  RegisteredEventsModel._();

  factory RegisteredEventsModel.fromJson(Map<String, dynamic> json) => _$RegisteredEventsModelFromJson(json);
}