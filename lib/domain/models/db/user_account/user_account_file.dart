import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_account_file.freezed.dart';
part 'user_account_file.g.dart';

@freezed
class UserAccountFile with _$UserAccountFile {

  factory UserAccountFile({
    required Map<String, dynamic> data,
  }) = _UserAccountFile;

  UserAccountFile._();

  factory UserAccountFile.fromJson(Map<String, dynamic> json) => _$UserAccountFileFromJson(json);
}