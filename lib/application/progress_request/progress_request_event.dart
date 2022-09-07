part of 'progress_request_bloc.dart';

@freezed
class ProgressRequestEvent with _$ProgressRequestEvent {
  const factory ProgressRequestEvent.loadFromId({
    required int id,
    @Default(true) bool addToQueue,
  }) = _LoadEventFromId;
}