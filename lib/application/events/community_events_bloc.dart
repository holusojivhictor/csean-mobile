import 'package:csean_mobile/domain/enums/enum.dart';
import 'package:csean_mobile/domain/models/model.dart';
import 'package:csean_mobile/domain/services/csean_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:csean_mobile/domain/extensions/string_extensions.dart';

part 'community_events_bloc.freezed.dart';
part 'community_events_event.dart';
part 'community_events_state.dart';

class CommunityEventsBloc extends Bloc<CommunityEventsEvent, CommunityEventsState> {
  final CseanService _cseanService;
  
  CommunityEventsBloc(this._cseanService) : super(const CommunityEventsState.loading());

  _LoadedState get currentState => state as _LoadedState;

  @override
  Stream<CommunityEventsState> mapEventToState(CommunityEventsEvent event) async* {
    final s = event.map(
      init: (e) => _buildInitialState(excludeKeys: e.excludeKeys, eventTypes: EventType.values, paymentTypes: EventPaymentType.values),
      eventFilterChanged: (e) => currentState.copyWith.call(tempEventFilterType: e.filterType),
      sortDirectionChanged: (e) => currentState.copyWith.call(tempSortDirectionType: e.sortDirectionType),
      itemRegisterStatusChanged: (e) => currentState.copyWith.call(tempStatusType: e.statusType),
      eventTypeChanged: (e) {
        var types = <EventType>[];
        if (currentState.tempEventTypes.contains(e.eventType)) {
          types = currentState.tempEventTypes.where((t) => t != e.eventType).toList();
        } else {
          types = currentState.tempEventTypes + [e.eventType];
        }
        return currentState.copyWith.call(tempEventTypes: types);
      },
      eventPaymentTypeChanged: (e) {
        var types = <EventPaymentType>[];
        if (currentState.tempPaymentTypes.contains(e.paymentType)) {
          types = currentState.tempPaymentTypes.where((t) => t != e.paymentType).toList();
        } else {
          types = currentState.tempPaymentTypes + [e.paymentType];
        }
        return currentState.copyWith.call(tempPaymentTypes: types);
      },
      searchChanged: (e) => _buildInitialState(
        search: e.search,
        statusType: currentState.statusType,
        eventFilterType: currentState.eventFilterType,
        sortDirectionType: currentState.sortDirectionType,
        eventTypes: currentState.eventTypes,
        paymentTypes: currentState.paymentTypes,
        excludeKeys: currentState.excludeKeys,
      ),
      applyFilterChanges: (_) => _buildInitialState(
        search: currentState.search,
        statusType: currentState.tempStatusType,
        eventFilterType: currentState.tempEventFilterType,
        sortDirectionType: currentState.tempSortDirectionType,
        eventTypes: currentState.tempEventTypes,
        paymentTypes: currentState.tempPaymentTypes,
        excludeKeys: currentState.excludeKeys,
      ),
      cancelChanges: (_) => currentState.copyWith.call(
        tempStatusType: currentState.statusType,
        tempEventTypes: currentState.eventTypes,
        tempPaymentTypes: currentState.paymentTypes,
        tempEventFilterType: currentState.eventFilterType,
        tempSortDirectionType: currentState.sortDirectionType,
        excludeKeys: currentState.excludeKeys,
      ),
      resetFilters: (_) => _buildInitialState(
        excludeKeys: state.maybeMap(loaded: (state) => state.excludeKeys, orElse: () => []),
        eventTypes: EventType.values,
        paymentTypes: EventPaymentType.values,
      ),
    );

    yield s;
  }

  CommunityEventsState _buildInitialState({
    String? search,
    List<int> excludeKeys = const [],
    List<EventPaymentType> paymentTypes = const [],
    List<EventType> eventTypes = const [],
    ItemRegisterStatusType? statusType,
    EventFilterType eventFilterType = EventFilterType.title,
    SortDirectionType sortDirectionType = SortDirectionType.asc,
  }) {
    final isLoaded = state is _LoadedState;
    var allEvents = _cseanService.getEventsForCard();
    var data = allEvents.where((el) => el.privacy != 1).toList();
    final profileData = _cseanService.getProfileData();
    var chapterEvents = allEvents.where((el) => el.privacy == 1 && el.chapterId == profileData.profile.chapterId).toList();
    if (excludeKeys.isNotEmpty) {
      data = data.where((el) => !excludeKeys.contains(el.id)).toList();
    }

    if (!isLoaded) {
      final selectedPaymentTypes = EventPaymentType.values.toList();
      final selectedEventTypes = EventType.values.toList();
      _sortData(data, eventFilterType, sortDirectionType);
      return CommunityEventsState.loaded(
        events: data,
        chapterEvents: chapterEvents,
        search: search,
        paymentTypes: selectedPaymentTypes,
        tempPaymentTypes: selectedPaymentTypes,
        statusType: statusType,
        tempStatusType: statusType,
        eventTypes: selectedEventTypes,
        tempEventTypes: selectedEventTypes,
        eventFilterType: eventFilterType,
        tempEventFilterType: eventFilterType,
        sortDirectionType: sortDirectionType,
        tempSortDirectionType: sortDirectionType,
        excludeKeys: excludeKeys,
      );
    }

    if (search != null && search.isNotEmpty) {
      data = data.where((el) => el.title.toLowerCase().contains(search.toLowerCase())).toList();
    }

    if (paymentTypes.isNotEmpty) {
      data = data.where((el) => paymentTypes.contains(el.type)).toList();
    }

    if (eventTypes.isNotEmpty) {
      data = data.where((el) => eventTypes.contains(el.eventType)).toList();
    }

    switch (statusType) {
      case ItemRegisterStatusType.registered:
        data = data.where((el) => el.subscribed).toList();
        break;
      case ItemRegisterStatusType.notRegistered:
        data = data.where((el) => !el.subscribed).toList();
        break;
      default:
        break;
    }

    _sortData(data, eventFilterType, sortDirectionType);

    final s = currentState.copyWith.call(
      events: data,
      chapterEvents: chapterEvents,
      search: search,
      paymentTypes: paymentTypes,
      tempPaymentTypes: paymentTypes,
      statusType: statusType,
      tempStatusType: statusType,
      eventTypes: eventTypes,
      tempEventTypes: eventTypes,
      eventFilterType: eventFilterType,
      tempEventFilterType: eventFilterType,
      sortDirectionType: sortDirectionType,
      tempSortDirectionType: sortDirectionType,
      excludeKeys: excludeKeys,
    );

    return s;
  }

  List<int> getItemKeysToExclude() {
    final excludeKeys = _cseanService.getEventsExcludeKeys();
    return excludeKeys;
  }

  void _sortData(List<EventCardModel> data, EventFilterType eventFilterType, SortDirectionType sortDirectionType) {
    switch (eventFilterType) {
      case EventFilterType.date:
        if (sortDirectionType == SortDirectionType.asc) {
          data.sort((x, y) => x.dateString.getSecondsFromEpoch().compareTo(y.dateString.getSecondsFromEpoch()));
        } else {
          data.sort((x, y) => y.dateString.getSecondsFromEpoch().compareTo(x.dateString.getSecondsFromEpoch()));
        }
        break;
      case EventFilterType.title:
        if (sortDirectionType == SortDirectionType.asc) {
          data.sort((x, y) => x.title.compareTo(y.title));
        } else {
          data.sort((x, y) => y.title.compareTo(x.title));
        }
        break;
      default:
        break;
    }
  }
}
