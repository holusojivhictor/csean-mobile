import 'package:csean_mobile/application/common/pob_bloc.dart';
import 'package:csean_mobile/domain/enums/enum.dart';
import 'package:csean_mobile/domain/models/model.dart';
import 'package:csean_mobile/domain/services/csean_service.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'progress_request_bloc.freezed.dart';
part 'progress_request_event.dart';
part 'progress_request_state.dart';

class ProgressRequestBloc extends PopBloc<ProgressRequestEvent, ProgressRequestState> {
  final CseanService _cseanService;

  ProgressRequestBloc(this._cseanService) : super(const ProgressRequestState.loading());

  @override
  ProgressRequestEvent getEventForPop(int? id) => ProgressRequestEvent.loadFromId(id: id!, addToQueue: false);

  @override
  Stream<ProgressRequestState> mapEventToState(ProgressRequestEvent event) async* {
    final s = await event.when(
      loadFromId: (id, addToQueue) async {
        final activity = _cseanService.getActivity(id);

        if (addToQueue) {
          currentItemsInStack.add(activity.id);
        }
        return _buildInitialState(activity);
      },
    );

    yield s;
  }

  ProgressRequestState _buildInitialState(ProgressActivityModel activity) {
    final isSubmitted = _cseanService.reportedActivities().contains(activity.id);
    return ProgressRequestState.loaded(
      id: activity.id,
      title: activity.title,
      activityType: activity.activityType,
      point: activity.point,
      createdAt: activity.createdAt,
      accepted: activity.accepted,
      isSubmitted: isSubmitted,
    );
  }
}