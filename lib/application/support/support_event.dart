part of 'support_bloc.dart';

@freezed
class SupportEvent with _$SupportEvent {
  const factory SupportEvent.init() = _Init;

  const factory SupportEvent.searchChanged({
    required String search,
  }) = _SearchChanged;

  const factory SupportEvent.supportStageTypeChanged(SupportStageType stageType) = _SupportStageTypeChanged;

  const factory SupportEvent.ticketFilterTypeChanged(TicketFilterType filterType) = _TicketFilterTypeChanged;

  const factory SupportEvent.applyFilterChanges() = _ApplyFilterChanges;

  const factory SupportEvent.sortDirectionChanged(SortDirectionType sortDirectionType) = _SortDirectionChanged;

  const factory SupportEvent.cancelChanges() = _CancelChanges;

  const factory SupportEvent.resetFilters() = _ResetFilters;
}