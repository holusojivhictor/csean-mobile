// ignore_for_file: invalid_annotation_target

import 'package:csean_mobile/domain/enums/enum.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'blog_file_model.freezed.dart';
part 'blog_file_model.g.dart';

@freezed
class BlogFileModel with _$BlogFileModel {

  factory BlogFileModel({
    required int id,
    required String title,
    required String content,
    @JsonKey(name: 'author_id') required int authorId,
    @JsonKey(name: 'category_id') required int categoryId,
    required AuthorModel author,
    required CategoryModel category,
    @JsonKey(name: 'created_at') required String createdAt,
    @JsonKey(name: 'file_url' )required String fileUrl,
  }) = _BlogFileModel;

  BlogFileModel._();

  factory BlogFileModel.fromJson(Map<String, dynamic> json) => _$BlogFileModelFromJson(json);
}

@freezed
class AuthorModel with _$AuthorModel {

  factory AuthorModel({
    required AccountType type,
    @JsonKey(name: 'firstname') required String firstName,
    @JsonKey(name: 'lastname') required String lastName,
    required String email,
  }) = _AuthorModel;

  AuthorModel._();

  factory AuthorModel.fromJson(Map<String, dynamic> json) => _$AuthorModelFromJson(json);
}

@freezed
class CategoryModel with _$CategoryModel {

  factory CategoryModel({
    required int id,
    required String name,
    String? description,
  }) = _CategoryModel;

  CategoryModel._();

  factory CategoryModel.fromJson(Map<String, dynamic> json) => _$CategoryModelFromJson(json);
}