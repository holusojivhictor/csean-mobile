part of 'data_bloc.dart';

@freezed
class DataState with _$DataState {
  const factory DataState.loading() = _LoadingState;

  const factory DataState.loaded({
    @Default(false) bool isDoneUpdating,
  }) = _LoadedState;
}