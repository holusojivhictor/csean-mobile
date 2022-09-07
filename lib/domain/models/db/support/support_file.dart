import 'package:freezed_annotation/freezed_annotation.dart';

part 'support_file.freezed.dart';
part 'support_file.g.dart';

@freezed
class SupportFile with _$SupportFile {
  factory SupportFile({
    required Map<String, dynamic> supports,
  }) = _SupportFile;

  SupportFile._();

  factory SupportFile.fromJson(Map<String, dynamic> json) => _$SupportFileFromJson(json);
}