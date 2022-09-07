import 'package:csean_mobile/domain/models/model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'item_data_file.freezed.dart';
part 'item_data_file.g.dart';

@freezed
class ItemDataFile with _$ItemDataFile {
  factory ItemDataFile({
    required List<SubCategoryItemModel> data,
  }) = _ItemDataFile;

  ItemDataFile._();

  factory ItemDataFile.fromJson(Map<String, dynamic> json) => _$ItemDataFileFromJson(json);
}