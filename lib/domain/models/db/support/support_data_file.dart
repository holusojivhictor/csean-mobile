import 'package:csean_mobile/domain/models/model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'support_data_file.freezed.dart';
part 'support_data_file.g.dart';

@freezed
class SupportDataFile with _$SupportDataFile {
  factory SupportDataFile({
    required List<SupportFileModel> data,
  }) = _SupportDataFile;

  SupportDataFile._();

  factory SupportDataFile.fromJson(Map<String, dynamic> json) => _$SupportDataFileFromJson(json);
}