part of 'blog_bloc.dart';

@freezed
class BlogState with _$BlogState {
  const factory BlogState.loading() = _LoadingState;

  const factory BlogState.loaded({
    required int id,
    required String title,
    required String content,
    required AuthorCardModel author,
    required CategoryCardModel category,
    required String createdAt,
    required String fileUrl,
  }) = _LoadedState;
}