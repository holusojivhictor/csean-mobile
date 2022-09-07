part of 'resource_bloc.dart';

@freezed
class ResourceEvent with _$ResourceEvent {
  const factory ResourceEvent.loadFromIds({
    required int categoryId,
    required int subCategoryId,
    @Default(true) bool addToQueue,
  }) = _LoadResourcesFromIds;
}