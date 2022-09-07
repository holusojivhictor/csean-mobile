part of 'community_events_bloc.dart';

@freezed
class CommunityEventsState with _$CommunityEventsState {
  const factory CommunityEventsState.loading() = _LoadingState;

  const factory CommunityEventsState.loaded({
    required List<EventCardModel> events,
    required List<EventCardModel> chapterEvents,
    String? search,
    required List<EventPaymentType> paymentTypes,
    required List<EventPaymentType> tempPaymentTypes,
    ItemRegisterStatusType? statusType,
    ItemRegisterStatusType? tempStatusType,
    required List<EventType> eventTypes,
    required List<EventType> tempEventTypes,
    required EventFilterType eventFilterType,
    required EventFilterType tempEventFilterType,
    required SortDirectionType sortDirectionType,
    required SortDirectionType tempSortDirectionType,
    @Default(<int>[]) List<int> excludeKeys,
  }) = _LoadedState;
}