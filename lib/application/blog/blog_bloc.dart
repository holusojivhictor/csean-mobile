import 'package:csean_mobile/application/common/pob_bloc.dart';
import 'package:csean_mobile/domain/models/model.dart';
import 'package:csean_mobile/domain/services/csean_service.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'blog_bloc.freezed.dart';
part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends PopBloc<BlogEvent, BlogState> {
  final CseanService _cseanService;

  BlogBloc(this._cseanService) : super(const BlogState.loading());

  @override
  BlogEvent getEventForPop(int? id) => BlogEvent.loadFromId(id: id!, addToQueue: false);

  @override
  Stream<BlogState> mapEventToState(BlogEvent event) async* {
    final s = await event.when(
      loadFromId: (id, addToQueue) async {
        final blog = _cseanService.getBlog(id);

        if (addToQueue) {
          currentItemsInStack.add(blog.id);
        }
        return _buildInitialState(blog);
      },
    );

    yield s;
  }

  BlogState _buildInitialState(BlogFileModel blog) {
    AuthorCardModel _toAuthorForCard(AuthorModel model) {
      return AuthorCardModel(
        type: model.type,
        firstName: model.firstName,
        lastName: model.lastName,
        email: model.email,
      );
    }

    CategoryCardModel _toCategoryForCard(CategoryModel model) {
      return CategoryCardModel(
        id: model.id,
        name: model.name,
        description: model.description,
      );
    }

    final author = _toAuthorForCard(blog.author);
    final category = _toCategoryForCard(blog.category);

    return BlogState.loaded(
      id: blog.id,
      title: blog.title,
      content: blog.content,
      author: author,
      category: category,
      createdAt:blog.createdAt,
      fileUrl: blog.fileUrl,
    );
  }
}