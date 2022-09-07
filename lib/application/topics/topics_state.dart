part of 'topics_bloc.dart';

@freezed
class TopicsState with _$TopicsState {
  const factory TopicsState.loading() = _LoadingState;

  const factory TopicsState.loaded({
    required List<TopicCardModel> topics,
  }) = _LoadedState;
}