// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_file_model.freezed.dart';
part 'payment_file_model.g.dart';

@freezed
class PaymentFileModel with _$PaymentFileModel {
  factory PaymentFileModel({
    required double amount,
    required String url,
    @JsonKey(name: 'access_code') required String accessCode,
    required String reference,
  }) = _PaymentFileModel;

  PaymentFileModel._();

  factory PaymentFileModel.fromJson(Map<String, dynamic> json) => _$PaymentFileModelFromJson(json);
}