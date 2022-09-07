part of 'blogs_bloc.dart';

@freezed
class BlogsEvent with _$BlogsEvent {
  const factory BlogsEvent.init() = _Init;

  const factory BlogsEvent.searchChanged({
    required String search,
  }) = _SearchChanged;
}