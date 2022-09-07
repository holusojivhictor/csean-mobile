// ignore_for_file: invalid_annotation_target

import 'package:csean_mobile/domain/enums/enum.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'progress_file_model.freezed.dart';
part 'progress_file_model.g.dart';

@freezed
class ProgressTrackerModel with _$ProgressTrackerModel {
  factory ProgressTrackerModel({
    required int id,
    @JsonKey(name: 'admin_id') required int adminId,
    @JsonKey(name: 'target_point') required int targetPoint,
    @JsonKey(name: 'target_period') required int targetPeriod,
    @JsonKey(name: 'target_timeline') required String targetTimeline,
  }) = _ProgressTrackerModel;

  ProgressTrackerModel._();

  factory ProgressTrackerModel.fromJson(Map<String, dynamic> json) => _$ProgressTrackerModelFromJson(json);
}

@freezed
class ProgressActivityModel with _$ProgressActivityModel {
  factory ProgressActivityModel({
    required int id,
    required String title,
    @JsonKey(name: 'type') required ProgressActivityType activityType,
    required int point,
    @JsonKey(name: 'created_at') required String createdAt,
    required bool accepted,
  }) = _ProgressActivityModel;

  ProgressActivityModel._();

  factory ProgressActivityModel.fromJson(Map<String, dynamic> json) => _$ProgressActivityModelFromJson(json);
}

@freezed
class ProgressReportModel with _$ProgressReportModel {
  factory ProgressReportModel({
    @JsonKey(name: 'total_point') required int totalPoints,
    @JsonKey(name: 'remaining') required int remainingPoints,
    required int pending,
    required int approved,
    required int declined,
  }) = _ProgressReportModel;

  ProgressReportModel._();

  factory ProgressReportModel.fromJson(Map<String, dynamic> json) => _$ProgressReportModelFromJson(json);
}

@freezed
class ProgressRequestModel with _$ProgressRequestModel {
  factory ProgressRequestModel({
    required int id,
    @JsonKey(name: 'user_id') required int userId,
    @JsonKey(name: 'activity_id') required int activityId,
    String? note,
    @JsonKey(name: 'validation_note') String? validationNote,
    @JsonKey(name: 'completed_at') required String completedAt,
    required int status,
    @JsonKey(name: 'created_at') required String createdAt,
    @JsonKey(name: 'state') required ProgressRequestState requestState,
    @JsonKey(name: 'file_url') required String fileUrl,
  }) = _ProgressRequestModel;

  ProgressRequestModel._();

  factory ProgressRequestModel.fromJson(Map<String, dynamic> json) => _$ProgressRequestModelFromJson(json);
}