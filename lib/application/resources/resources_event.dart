part of 'resources_bloc.dart';

@freezed
class ResourcesEvent with _$ResourcesEvent {
  const factory ResourcesEvent.init() = _Init;

  const factory ResourcesEvent.searchChanged({
    required String search,
  }) = _SearchChanged;

  const factory ResourcesEvent.categoryTypeChanged(ResourceCategoryType? categoryType) = _CategoryTypeChanged;

  const factory ResourcesEvent.applyFilterChanges() = _ApplyFilterChanges;
}