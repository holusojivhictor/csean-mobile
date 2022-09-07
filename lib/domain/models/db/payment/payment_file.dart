import 'package:csean_mobile/domain/models/model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_file.freezed.dart';
part 'payment_file.g.dart';

@freezed
class PaymentFile with _$PaymentFile {
  factory PaymentFile({
    required PaymentFileModel data,
  }) = _PaymentFile;

  PaymentFile._();

  factory PaymentFile.fromJson(Map<String, dynamic> json) => _$PaymentFileFromJson(json);
}