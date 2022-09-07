import 'package:csean_mobile/domain/enums/enum.dart';
import 'package:csean_mobile/domain/extensions/string_extensions.dart';
import 'package:csean_mobile/domain/models/model.dart';
import 'package:csean_mobile/domain/services/csean_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'support_bloc.freezed.dart';
part 'support_event.dart';
part 'support_state.dart';

class SupportBloc extends Bloc<SupportEvent, SupportState> {
  final CseanService _cseanService;

  SupportBloc(this._cseanService) : super(const SupportState.loading());

  _LoadedState get currentState => state as _LoadedState;

  @override
  Stream<SupportState> mapEventToState(SupportEvent event) async* {
    final s = event.map(
      init: (_) => _buildInitialState(stageTypes: SupportStageType.values),
      ticketFilterTypeChanged: (e) => currentState.copyWith.call(tempTicketFilterType: e.filterType),
      sortDirectionChanged: (e) => currentState.copyWith.call(tempSortDirectionType: e.sortDirectionType),
      supportStageTypeChanged: (e) {
        var types = <SupportStageType>[];
        if (currentState.tempStageTypes.contains(e.stageType)) {
          types = currentState.tempStageTypes.where((t) => t != e.stageType).toList();
        } else {
          types = currentState.tempStageTypes + [e.stageType];
        }
        return currentState.copyWith.call(tempStageTypes: types);
      },
      searchChanged: (e) => _buildInitialState(
        search: e.search,
        stageTypes: currentState.stageTypes,
        ticketFilterType: currentState.ticketFilterType,
        sortDirectionType: currentState.sortDirectionType,
      ),
      applyFilterChanges: (_) => _buildInitialState(
        search: currentState.search,
        stageTypes: currentState.tempStageTypes,
        ticketFilterType: currentState.tempTicketFilterType,
        sortDirectionType: currentState.tempSortDirectionType,
      ),
      cancelChanges: (_) => currentState.copyWith.call(
        tempStageTypes: currentState.stageTypes,
        tempTicketFilterType: currentState.ticketFilterType,
        tempSortDirectionType: currentState.sortDirectionType,
      ),
      resetFilters: (_) => _buildInitialState(stageTypes: SupportStageType.values),
    );

    yield s;
  }

  SupportState _buildInitialState({
    String? search,
    List<SupportStageType> stageTypes = const [],
    TicketFilterType ticketFilterType = TicketFilterType.date,
    SortDirectionType sortDirectionType = SortDirectionType.desc,
  }) {
    final isLoaded = state is _LoadedState;
    var data = _cseanService.getTicketsForCard();

    if (!isLoaded) {
      final selectedStageTypes = SupportStageType.values.toList();
      _sortData(data, ticketFilterType, sortDirectionType);
      return SupportState.loaded(
        tickets: data,
        search: search,
        stageTypes: selectedStageTypes,
        tempStageTypes: selectedStageTypes,
        ticketFilterType: ticketFilterType,
        tempTicketFilterType: ticketFilterType,
        sortDirectionType: sortDirectionType,
        tempSortDirectionType: sortDirectionType,
      );
    }

    if (search != null && search.isNotEmpty) {
      data = data.where((el) => el.subject.toLowerCase().contains(search.toLowerCase())).toList();
    }

    if (stageTypes.isNotEmpty) {
      data = data.where((el) => stageTypes.contains(el.supportStage)).toList();
    }

    _sortData(data, ticketFilterType, sortDirectionType);

    final s = currentState.copyWith.call(
      tickets: data,
      search: search,
      stageTypes: stageTypes,
      tempStageTypes: stageTypes,
      ticketFilterType: ticketFilterType,
      tempTicketFilterType: ticketFilterType,
      sortDirectionType: sortDirectionType,
      tempSortDirectionType: sortDirectionType,
    );

    return s;
  }

  void _sortData(List<TicketCardModel> data, TicketFilterType ticketFilterType, SortDirectionType sortDirectionType) {
    switch (ticketFilterType) {
      case TicketFilterType.subject:
        if (sortDirectionType == SortDirectionType.asc) {
          data.sort((x, y) => x.subject.compareTo(y.subject));
        } else {
          data.sort((x, y) => y.subject.compareTo(x.subject));
        }
        break;
      case TicketFilterType.date:
        if (sortDirectionType == SortDirectionType.asc) {
          data.sort((x, y) => x.createdAt.getSecondsFromEpoch().compareTo(y.createdAt.getSecondsFromEpoch()));
        } else {
          data.sort((x, y) => y.createdAt.getSecondsFromEpoch().compareTo(x.createdAt.getSecondsFromEpoch()));
        }
        break;
      default:
        break;
    }
  }
}