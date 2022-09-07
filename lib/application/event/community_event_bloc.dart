import 'package:csean_mobile/application/common/pob_bloc.dart';
import 'package:csean_mobile/domain/enums/enum.dart';
import 'package:csean_mobile/domain/models/model.dart';
import 'package:csean_mobile/domain/services/csean_service.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'community_event_bloc.freezed.dart';
part 'community_event_event.dart';
part 'community_event_state.dart';

class CommunityEventBloc extends PopBloc<CommunityEventEvent, CommunityEventState> {
  final CseanService _cseanService;

  CommunityEventBloc(this._cseanService) : super(const CommunityEventState.loading());

  @override
  CommunityEventEvent getEventForPop(int? id) => CommunityEventEvent.loadFromId(id: id!, addToQueue: false);

  @override
  Stream<CommunityEventState> mapEventToState(CommunityEventEvent event) async* {
    if (event is! _IsSubscribedTo) {
      yield const CommunityEventState.loading();
    }

    final s = await event.when(
      loadFromId: (id, addToQueue) async {
        final event = _cseanService.getEvent(id);

        if (addToQueue) {
          currentItemsInStack.add(event.id);
        }
        return _buildInitialState(event);
      },
      isSubscribedTo: (id, wasAdded) async {
        if (state is! _LoadedState) {
          return state;
        }

        final currentState = state as _LoadedState;
        if (currentState.id != id) {
          return state;
        }

        return currentState.copyWith.call(isSubscribedTo: wasAdded, addSub: true);
      },
    );

    yield s;
  }

  CommunityEventState _buildInitialState(EventFileModel event) {
    final isSubscribedTo = _cseanService.isEventSubscribedTo(event.id);

    return CommunityEventState.loaded(
      id: event.id,
      chapterId: event.nonNullChapterId,
      categoryId: event.categoryId,
      title: event.title,
      date: event.date,
      time: event.time,
      venue: event.venue,
      span: event.span,
      paymentType: event.type,
      eventType: event.eventType,
      fileUrl: event.fileUrl,
      video: event.convertedUrl,
      details: event.description,
      isSubscribedTo: isSubscribedTo,
      subscribed: event.subscribe,
      addSub: false,
      totalSubscribers: event.totalSubscribers,
    );
  }
}