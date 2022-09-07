import 'package:csean_mobile/domain/models/model.dart';
import 'package:csean_mobile/domain/services/csean_service.dart';
import 'package:csean_mobile/domain/extensions/string_extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'messages_bloc.freezed.dart';
part 'messages_event.dart';
part 'messages_state.dart';

class MessagesBloc extends Bloc<MessagesEvent, MessagesState> {
  final CseanService _cseanService;

  MessagesBloc(this._cseanService) : super(const MessagesState.loading());

  @override
  Stream<MessagesState> mapEventToState(MessagesEvent event) async* {
    final s = event.map(
      init: (e) => _buildInitialState(e.id),
      messageAdded: (e) {
        if (state is! _LoadedState) {
          return state;
        }

        final currentState = state as _LoadedState;
        if (currentState.topic.id != e.id) {
          return state;
        }

        var data = _cseanService.getMessagesForCardWithTopicId(e.id);

        return currentState.copyWith.call(messages: data);
      },
    );

    yield s;
  }

  MessagesState _buildInitialState(int topicId) {
    var topic = _cseanService.getTopicForCard(topicId);
    var data = _cseanService.getMessagesForCardWithTopicId(topicId);

    return MessagesState.loaded(
      messages: data,
      topic: topic,
    );
  }

  void _sortData(List<MessageCardModel> data) {
    data.sort((x, y) => x.dateString.getSecondsFromEpoch().compareTo(y.dateString.getSecondsFromEpoch()));
  }
}
