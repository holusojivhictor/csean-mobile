part of 'forums_bloc.dart';

@freezed
class ForumsState with _$ForumsState {
  const factory ForumsState.loading() = _LoadingState;

  const factory ForumsState.loaded({
    required List<ForumCardModel> forums,
    required ForumCardModel chapterForum,
    String? search,
    required ForumFilterType forumFilterType,
    required ForumFilterType tempForumFilterType,
    required SortDirectionType sortDirectionType,
    required SortDirectionType tempSortDirectionType,
  }) = _LoadedState;
}