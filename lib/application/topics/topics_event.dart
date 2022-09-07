part of 'topics_bloc.dart';

@freezed
class TopicsEvent with _$TopicsEvent {
  const factory TopicsEvent.init({
    required int id,
    @Default(true) bool addToQueue,
  }) = _Init;
}