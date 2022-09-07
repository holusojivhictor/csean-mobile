part of 'resources_bloc.dart';

@freezed
class ResourcesState with _$ResourcesState {
  const factory ResourcesState.loading() = _LoadingState;

  const factory ResourcesState.loaded({
    required List<SubCategoryCardModel> subCategories,
    String? search,
    ResourceCategoryType? categoryType,
    ResourceCategoryType? tempCategoryType,
  }) = _LoadedState;
}