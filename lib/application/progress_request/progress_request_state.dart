part of 'progress_request_bloc.dart';

@freezed
class ProgressRequestState with _$ProgressRequestState {
  const factory ProgressRequestState.loading() = _LoadingState;

  const factory ProgressRequestState.loaded({
    required int id,
    required String title,
    required ProgressActivityType activityType,
    required int point,
    required String createdAt,
    required bool accepted,
    required bool isSubmitted,
  }) = _LoadedState;
}