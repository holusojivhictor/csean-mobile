part of 'community_events_bloc.dart';

@freezed
class CommunityEventsEvent with _$CommunityEventsEvent {
  const factory CommunityEventsEvent.init({
    @Default(<int>[]) List<int> excludeKeys,
  }) = _Init;

  const factory CommunityEventsEvent.searchChanged({
    required String search,
  }) = _SearchChanged;

  const factory CommunityEventsEvent.eventPaymentTypeChanged(EventPaymentType paymentType) = _EventPaymentTypeChanged;

  const factory CommunityEventsEvent.eventTypeChanged(EventType eventType) = _EventTypeChanged;

  const factory CommunityEventsEvent.itemRegisterStatusChanged(ItemRegisterStatusType? statusType) = _RegisterStatusTypeChanged;

  const factory CommunityEventsEvent.eventFilterChanged(EventFilterType filterType) = _EventFilterTypeChanged;

  const factory CommunityEventsEvent.applyFilterChanges() = _ApplyFilterChanges;

  const factory CommunityEventsEvent.sortDirectionChanged(SortDirectionType sortDirectionType) = _SortDirectionChanged;

  const factory CommunityEventsEvent.cancelChanges() = _CancelChanges;

  const factory CommunityEventsEvent.resetFilters() = _ResetFilters;
}