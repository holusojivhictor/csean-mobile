part of 'blogs_bloc.dart';

@freezed
class BlogsState with _$BlogsState {
  const factory BlogsState.loading() = _LoadingState;

  const factory BlogsState.loaded({
    required List<BlogCardModel> blogs,
    String? search,
  }) = _LoadedState;
}