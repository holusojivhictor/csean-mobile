import 'package:csean_mobile/domain/models/model.dart';
import 'package:csean_mobile/domain/services/csean_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'topics_bloc.freezed.dart';
part 'topics_event.dart';
part 'topics_state.dart';

class TopicsBloc extends Bloc<TopicsEvent, TopicsState> {
  final CseanService _cseanService;

  TopicsBloc(this._cseanService) : super(const TopicsState.loading());

  @override
  Stream<TopicsState> mapEventToState(TopicsEvent event) async* {
    final s = event.map(
      init: (e) => _buildInitialState(e.id),
    );

    yield s;
  }

  TopicsState _buildInitialState(int forumId) {
    var data = _cseanService.getTopicsForCardWithForumId(forumId);

    return TopicsState.loaded(
      topics: data,
    );
  }
}