// ignore_for_file: invalid_annotation_target

import 'package:csean_mobile/domain/enums/enum.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'learning_category_model.freezed.dart';
part 'learning_category_model.g.dart';

@freezed
class LearningCategoryModel with _$LearningCategoryModel {
  factory LearningCategoryModel({
    required int id,
    @JsonKey(name: 'name') required ResourceCategoryType type,
    String? description,
    @JsonKey(name: 'categories') required List<SubCategoryModel> subCategories,
  }) = _LearningCategoryModel;

  LearningCategoryModel._();

  factory LearningCategoryModel.fromJson(Map<String, dynamic> json) => _$LearningCategoryModelFromJson(json);
}

@freezed
class SubCategoryModel with _$SubCategoryModel {
  factory SubCategoryModel({
    required int id,
    @JsonKey(name: 'category_id') required int categoryId,
    required String name,
    String? description,
  }) = _SubCategoryModel;

  SubCategoryModel._();

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) => _$SubCategoryModelFromJson(json);
}