// ignore_for_file: invalid_annotation_target

import 'package:csean_mobile/domain/models/model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_file.freezed.dart';
part 'category_file.g.dart';

@freezed
class CategoryFile with _$CategoryFile {
  factory CategoryFile({
    required List<LearningCategoryModel> categories,
  }) = _CategoryFile;

  CategoryFile._();

  factory CategoryFile.fromJson(Map<String, dynamic> json) => _$CategoryFileFromJson(json);
}