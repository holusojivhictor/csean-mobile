part of 'community_event_bloc.dart';

@freezed
class CommunityEventEvent with _$CommunityEventEvent {
  const factory CommunityEventEvent.loadFromId({
    required int id,
    @Default(true) bool addToQueue,
  }) = _LoadEventFromId;

  const factory CommunityEventEvent.isSubscribedTo({
    required int id,
    required bool wasAdded,
  }) = _IsSubscribedTo;
}