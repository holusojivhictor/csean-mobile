// ignore_for_file: invalid_annotation_target

import 'package:csean_mobile/domain/models/model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_account_data_file.freezed.dart';
part 'user_account_data_file.g.dart';

@freezed
class UserAccountDataFile with _$UserAccountDataFile {
  factory UserAccountDataFile({
    required UserAccountModel user,
    @JsonKey(name: 'subscribtion') SubscriptionModel? subscription,
  }) = _UserAccountDataFile;

  UserAccountDataFile._();

  factory UserAccountDataFile.fromJson(Map<String, dynamic> json) => _$UserAccountDataFileFromJson(json);
}

