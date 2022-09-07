part of 'progress_tracker_bloc.dart';

@freezed
class ProgressTrackerEvent with _$ProgressTrackerEvent {
  const factory ProgressTrackerEvent.init() = _Init;

  const factory ProgressTrackerEvent.activityChanged({
    required ActivityCardModel newValue,
  }) = _ActivityChanged;
}