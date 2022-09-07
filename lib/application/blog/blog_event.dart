part of 'blog_bloc.dart';

@freezed
class BlogEvent with _$BlogEvent {
  const factory BlogEvent.loadFromId({
    required int id,
    @Default(true) bool addToQueue,
  }) = _LoadBlogFromId;
}