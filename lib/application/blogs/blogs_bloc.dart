import 'package:csean_mobile/domain/enums/enum.dart';
import 'package:csean_mobile/domain/models/model.dart';
import 'package:csean_mobile/domain/services/csean_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'blogs_bloc.freezed.dart';
part 'blogs_event.dart';
part 'blogs_state.dart';

class BlogsBloc extends Bloc<BlogsEvent, BlogsState> {
  final CseanService _cseanService;

  BlogsBloc(this._cseanService) : super(const BlogsState.loading());

  _LoadedState get currentState => state as _LoadedState;

  @override
  Stream<BlogsState> mapEventToState(BlogsEvent event) async* {
    final s = event.map(
      init: (_) => _buildInitialState(),
      searchChanged: (e) => _buildInitialState(search: e.search),
    );

    yield s;
  }

  BlogsState _buildInitialState({
    String? search,
    BlogFilterType blogFilterType = BlogFilterType.title,
    SortDirectionType sortDirectionType = SortDirectionType.asc,
  }) {
    final isLoaded = state is _LoadedState;
    var data = _cseanService.getBlogsForCard();

    if (!isLoaded) {
      _sortData(data, blogFilterType, sortDirectionType);
      return BlogsState.loaded(
        blogs: data,
        search: search,
      );
    }

    if (search != null && search.isNotEmpty) {
      data = data.where((el) => el.title.toLowerCase().contains(search.toLowerCase())).toList();
    }

    _sortData(data, blogFilterType, sortDirectionType);

    final s = currentState.copyWith.call(
      blogs: data,
      search: search,
    );

    return s;
  }

  void _sortData(List<BlogCardModel> data, BlogFilterType blogFilterType, SortDirectionType sortDirectionType) {
    switch (blogFilterType) {
      case BlogFilterType.title:
        if (sortDirectionType == SortDirectionType.asc) {
          data.sort((x, y) => x.title.compareTo(y.title));
        } else {
          data.sort((x, y) => y.title.compareTo(x.title));
        }
        break;
      default:
        break;
    }
  }
}
