// ignore_for_file: invalid_annotation_target

import 'package:csean_mobile/domain/enums/enum.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sub_category_item_model.freezed.dart';
part 'sub_category_item_model.g.dart';

@freezed
class SubCategoryItemModel with _$SubCategoryItemModel {

  factory SubCategoryItemModel({
    required int id,
    @JsonKey(name: 'admin_id') required int adminId,
    @JsonKey(name: 'category_id') required int categoryId,
    @JsonKey(name: 'subcategory_id') required int subCategoryId,
    required String title,
    required ResourceType type,
    String? link,
    required String description,
    @JsonKey(name: 'created_at') required String createdAt,
    @JsonKey(name: 'file_url') required String fileUrl,
  }) = _SubCategoryItemModel;

  SubCategoryItemModel._();

  factory SubCategoryItemModel.fromJson(Map<String, dynamic> json) => _$SubCategoryItemModelFromJson(json);
}