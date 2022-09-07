part of 'messages_bloc.dart';

@freezed
class MessagesState with _$MessagesState {
  const factory MessagesState.loading() = _LoadingState;

  const factory MessagesState.loaded({
    required List<MessageCardModel> messages,
    required TopicCardModel topic,
  }) = _LoadedState;
}