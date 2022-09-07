import 'package:csean_mobile/domain/enums/enum.dart';
import 'package:csean_mobile/domain/models/model.dart';
import 'package:csean_mobile/domain/services/csean_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'resources_bloc.freezed.dart';
part 'resources_event.dart';
part 'resources_state.dart';

class ResourcesBloc extends Bloc<ResourcesEvent, ResourcesState> {
  final CseanService _cseanService;

  ResourcesBloc(this._cseanService) : super(const ResourcesState.loading());

  _LoadedState get currentState => state as _LoadedState;

  @override
  Stream<ResourcesState> mapEventToState(ResourcesEvent event) async* {
    final s = event.map(
      init: (_) => _buildInitialState(),
      searchChanged: (e) => _buildInitialState(search: e.search, categoryType: currentState.categoryType),
      categoryTypeChanged: (e) => currentState.copyWith.call(tempCategoryType: e.categoryType),
      applyFilterChanges: (_) => _buildInitialState(
        search: currentState.search,
        categoryType: currentState.tempCategoryType,
      )
    );

    yield s;
  }

  ResourcesState _buildInitialState({
    String? search,
    ResourceCategoryType? categoryType,
  }) {
    final isLoaded = state is _LoadedState;
    var data = _cseanService.getSubCategoriesForCard();

    if (!isLoaded) {
      return ResourcesState.loaded(
        subCategories: data,
        search: search,
        categoryType: categoryType,
        tempCategoryType: categoryType,
      );
    }

    if (search != null && search.isNotEmpty) {
      data = data.where((el) => el.name.toLowerCase().contains(search.toLowerCase())).toList();
    }

    switch (categoryType) {
      case ResourceCategoryType.Business:
        data = data.where((el) => el.categoryType == ResourceCategoryType.Business).toList();
        break;
      case ResourceCategoryType.Technology:
        data = data.where((el) => el.categoryType == ResourceCategoryType.Technology).toList();
        break;
      case ResourceCategoryType.Medical:
        data = data.where((el) => el.categoryType == ResourceCategoryType.Medical).toList();
        break;
      case ResourceCategoryType.Insurance:
        data = data.where((el) => el.categoryType == ResourceCategoryType.Insurance).toList();
        break;
      case ResourceCategoryType.Sport:
        data = data.where((el) => el.categoryType == ResourceCategoryType.Sport).toList();
        break;
      default:
        break;
    }

    final s = currentState.copyWith.call(
      subCategories: data,
      search: search,
      categoryType: categoryType,
      tempCategoryType: categoryType,
    );

    return s;
  }

  void _sortData(List<SubCategoryCardModel> data, ResourceCategoryType categoryType) {
    data = data.where((el) => el.categoryType == categoryType).toList();
  }
}
