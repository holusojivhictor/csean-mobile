// ignore_for_file: constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';

enum ResourceCategoryType {
  Business,
  Technology,
  Medical,
  @JsonValue('lnsurance') Insurance,
  Sport,
}