// ignore_for_file: invalid_annotation_target

import 'package:csean_mobile/domain/models/model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'progress_file.freezed.dart';
part 'progress_file.g.dart';

@freezed
class ProgressFile with _$ProgressFile {
  factory ProgressFile({
    required ProgressTrackerModel tracker,
    required List<ProgressActivityModel> activities,
    required ProgressReportModel report,
    @JsonKey(name: 'progress_requests') required List<ProgressRequestModel> progressRequests,
  }) = _ProgressFile;

  ProgressFile._();

  factory ProgressFile.fromJson(Map<String, dynamic> json) => _$ProgressFileFromJson(json);
}