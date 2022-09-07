part of 'forums_bloc.dart';

@freezed
class ForumsEvent with _$ForumsEvent {
  const factory ForumsEvent.init() = _Init;

  const factory ForumsEvent.searchChanged({
    required String search,
  }) = _SearchChanged;

  const factory ForumsEvent.forumFilterChanged(ForumFilterType filterType) = _ForumFilterTypeChanged;

  const factory ForumsEvent.applyFilterChanges() = _ApplyFilterChanges;

  const factory ForumsEvent.sortDirectionChanged(SortDirectionType sortDirectionType) = _SortDirectionChanged;

  const factory ForumsEvent.cancelChanges() = _CancelChanges;

  const factory ForumsEvent.resetFilters() = _ResetFilters;
}