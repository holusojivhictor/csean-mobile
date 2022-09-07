import 'package:freezed_annotation/freezed_annotation.dart';

enum SupportStageType {
  @JsonValue('New') newItem,
  @JsonValue('In Progress') inProgress,
  @JsonValue('Resolved') resolved
}