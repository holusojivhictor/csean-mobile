import 'package:csean_mobile/domain/enums/enum.dart';
import 'package:csean_mobile/domain/models/model.dart';
import 'package:csean_mobile/domain/services/csean_service.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'forums_bloc.freezed.dart';
part 'forums_event.dart';
part 'forums_state.dart';

class ForumsBloc extends Bloc<ForumsEvent, ForumsState> {
  final CseanService _cseanService;

  ForumsBloc(this._cseanService) : super(const ForumsState.loading());

  _LoadedState get currentState => state as _LoadedState;

  @override
  Stream<ForumsState> mapEventToState(ForumsEvent event) async* {
    final s = event.map(
      init: (_) => _buildInitialState(),
      forumFilterChanged: (e) => currentState.copyWith.call(tempForumFilterType: e.filterType),
      sortDirectionChanged: (e) => currentState.copyWith.call(tempSortDirectionType: e.sortDirectionType),
      searchChanged: (e) => _buildInitialState(
        search: e.search,
        forumFilterType: currentState.forumFilterType,
        sortDirectionType: currentState.sortDirectionType,
      ),
      applyFilterChanges: (_) => _buildInitialState(
        search: currentState.search,
        forumFilterType: currentState.tempForumFilterType,
        sortDirectionType: currentState.tempSortDirectionType,
      ),
      cancelChanges: (_) => currentState.copyWith.call(
        tempForumFilterType: currentState.forumFilterType,
        tempSortDirectionType: currentState.sortDirectionType,
      ),
      resetFilters: (_) => _buildInitialState(),
    );

    yield s;
  }

  ForumsState _buildInitialState({
    String? search,
    ForumFilterType forumFilterType = ForumFilterType.name,
    SortDirectionType sortDirectionType = SortDirectionType.asc,
  }) {
    final isLoaded = state is _LoadedState;
    final userData = _cseanService.getProfileData();
    var data = _cseanService.getForumsForCard();
    var chapterForum = _cseanService.getForumFromPrivacy(userData.profile.chapter!.name.name);

    if (!isLoaded) {
      _sortData(data, forumFilterType, sortDirectionType);
      return ForumsState.loaded(
        forums: data,
        chapterForum: chapterForum,
        search: search,
        forumFilterType: forumFilterType,
        tempForumFilterType: forumFilterType,
        sortDirectionType: sortDirectionType,
        tempSortDirectionType: sortDirectionType,
      );
    }

    if (search != null && search.isNotEmpty) {
      data = data.where((el) => el.name.toLowerCase().contains(search.toLowerCase())).toList();
    }

    _sortData(data, forumFilterType, sortDirectionType);

    final s = currentState.copyWith.call(
      forums: data,
      chapterForum: chapterForum,
      search: search,
      forumFilterType: forumFilterType,
      tempForumFilterType: forumFilterType,
      sortDirectionType: sortDirectionType,
      tempSortDirectionType: sortDirectionType,
    );

    return s;
  }

  void _sortData(List<ForumCardModel> data, ForumFilterType forumFilterType, SortDirectionType sortDirectionType) {
    switch (forumFilterType) {
      case ForumFilterType.name:
        if (sortDirectionType == SortDirectionType.asc) {
          data.sort((x, y) => x.name.compareTo(y.name));
        } else {
          data.sort((x, y) => y.name.compareTo(x.name));
        }
        break;
      default:
        break;
    }
  }
}
