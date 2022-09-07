// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_file_model.freezed.dart';
part 'transaction_file_model.g.dart';

@freezed
class TransactionFileModel with _$TransactionFileModel {
  factory TransactionFileModel({
    required int id,
    @JsonKey(name: 'user_id') required int userId,
    @JsonKey(name: 'card_id') required String cardId,
    @JsonKey(name: 'trxid') required String transactionId,
    required double amount,
    required String package,
    required String code,
    required String details,
    @JsonKey(name: 'created_at') required String createdAt,
  }) = _TransactionFileModel;

  TransactionFileModel._();

  factory TransactionFileModel.fromJson(Map<String, dynamic> json) => _$TransactionFileModelFromJson(json);
}