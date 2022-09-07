import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_file.freezed.dart';
part 'transaction_file.g.dart';

@freezed
class TransactionFile with _$TransactionFile {
  factory TransactionFile({
    required Map<String, dynamic> data,
  }) = _TransactionFile;

  TransactionFile._();

  factory TransactionFile.fromJson(Map<String, dynamic> json) => _$TransactionFileFromJson(json);
}