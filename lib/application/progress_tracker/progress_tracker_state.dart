part of 'progress_tracker_bloc.dart';

@freezed
class ProgressTrackerState with _$ProgressTrackerState {
  const factory ProgressTrackerState.loading() = _LoadingState;

  const factory ProgressTrackerState.loaded({
    required TrackerCardModel tracker,
    required List<ActivityCardModel> activities,
    required ReportCardModel report,
    required List<RequestCardModel> progressRequests,
    required ActivityCardModel currentActivity,
  }) = _LoadedState;
}