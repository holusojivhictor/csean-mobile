part of 'support_bloc.dart';

@freezed
class SupportState with _$SupportState {
  const factory SupportState.loading() = _LoadingState;

  const factory SupportState.loaded({
    required List<TicketCardModel> tickets,
    String? search,
    required List<SupportStageType> stageTypes,
    required List<SupportStageType> tempStageTypes,
    required TicketFilterType ticketFilterType,
    required TicketFilterType tempTicketFilterType,
    required SortDirectionType sortDirectionType,
    required SortDirectionType tempSortDirectionType,
  }) = _LoadedState;
}