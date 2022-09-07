import 'package:csean_mobile/domain/models/model.dart';
import 'package:csean_mobile/domain/services/csean_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'resource_bloc.freezed.dart';
part 'resource_event.dart';
part 'resource_state.dart';

class ResourceBloc extends Bloc<ResourceEvent, ResourceState> {
  final CseanService _cseanService;

  ResourceBloc(this._cseanService) : super(const ResourceState.loading());

  @override
  Stream<ResourceState> mapEventToState(ResourceEvent event) async* {
    final s = event.map(
      loadFromIds: (e) => _buildInitialState(e.categoryId, e.subCategoryId),
    );

    yield s;
  }

  ResourceState _buildInitialState(int categoryId, int subCategoryId) {
    var resources = _cseanService.getResourceItemsForCardWithIds(categoryId, subCategoryId);

    return ResourceState.loaded(
      resources: resources,
    );
  }
}