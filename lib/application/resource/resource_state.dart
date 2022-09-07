part of 'resource_bloc.dart';

@freezed
class ResourceState with _$ResourceState {
  const factory ResourceState.loading() = _LoadingState;

  const factory ResourceState.loaded({
    required List<ResourceItemCardModel> resources,
  }) = _LoadedState;
}