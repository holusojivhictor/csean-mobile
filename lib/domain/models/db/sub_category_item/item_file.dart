import 'package:freezed_annotation/freezed_annotation.dart';

part 'item_file.freezed.dart';
part 'item_file.g.dart';

@freezed
class ItemFile with _$ItemFile {
  factory ItemFile({
    required Map<String, dynamic> resources,
  }) = _ItemFile;

  ItemFile._();

  factory ItemFile.fromJson(Map<String, dynamic> json) => _$ItemFileFromJson(json);
}