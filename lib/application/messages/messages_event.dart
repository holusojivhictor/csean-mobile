part of 'messages_bloc.dart';

@freezed
class MessagesEvent with _$MessagesEvent {
  const factory MessagesEvent.init({
    required int id,
    @Default(true) bool addToQueue,
  }) = _Init;

  const factory MessagesEvent.messageAdded({
    required int id,
    required bool wasAdded,
  }) = _MessageAdded;
}