import 'package:csean_mobile/domain/models/model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_data_file.freezed.dart';
part 'transaction_data_file.g.dart';

@freezed
class TransactionDataFile with _$TransactionDataFile {
  factory TransactionDataFile({
    required List<TransactionFileModel> data,
  }) = _TransactionDataFile;

  TransactionDataFile._();

  factory TransactionDataFile.fromJson(Map<String, dynamic> json) => _$TransactionDataFileFromJson(json);
}