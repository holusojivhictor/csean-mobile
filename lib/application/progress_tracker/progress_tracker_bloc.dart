import 'package:csean_mobile/domain/models/model.dart';
import 'package:csean_mobile/domain/services/csean_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'progress_tracker_bloc.freezed.dart';
part 'progress_tracker_event.dart';
part 'progress_tracker_state.dart';

class ProgressTrackerBloc extends Bloc<ProgressTrackerEvent, ProgressTrackerState> {
  final CseanService _cseanService;

  ProgressTrackerBloc(this._cseanService) : super(const ProgressTrackerState.loading());

  _LoadedState get currentState => state as _LoadedState;

  @override
  Stream<ProgressTrackerState> mapEventToState(ProgressTrackerEvent event) async* {
    final s = event.map(
      init: (_) => _buildInitialState(),
      activityChanged: (e) => currentState.copyWith.call(currentActivity: e.newValue),
    );

    yield s;
  }

  ProgressTrackerState _buildInitialState() {
    final isLoaded = state is _LoadedState;
    var trackerData = _cseanService.getTrackerForCard();
    var activitiesData = _cseanService.getActivitiesForCard();
    var reportData = _cseanService.getReportForCard();
    var requestsData = _cseanService.getRequestsForCard();

    if (!isLoaded) {
      return ProgressTrackerState.loaded(
        tracker: trackerData,
        activities: activitiesData,
        report: reportData,
        progressRequests: requestsData,
        currentActivity: activitiesData[0],
      );
    }

    final s = currentState.copyWith.call(
      tracker: trackerData,
      activities: activitiesData,
      report: reportData,
      progressRequests: requestsData,
      currentActivity: activitiesData[0],
    );

    return s;
  }
}