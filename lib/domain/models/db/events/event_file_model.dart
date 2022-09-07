// ignore_for_file: invalid_annotation_target

import 'package:csean_mobile/domain/assets.dart';
import 'package:csean_mobile/domain/enums/enum.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event_file_model.freezed.dart';
part 'event_file_model.g.dart';

@freezed
class EventFileModel with _$EventFileModel {
  int get nonNullChapterId => Assets.getChapterId(chapterId);

  String get videoUrl => Assets.getVideoUrl(video);

  String get convertedUrl => Assets.convertUrlToId(videoUrl)!;

  String get description => Assets.getEventDescription(details);

  factory EventFileModel({
    required int id,
    required int privacy,
    @JsonKey(name: 'chapter_id') int? chapterId,
    required String code,
    required String title,
    @JsonKey(name: 'category_id') required int categoryId,
    required String date,
    required String time,
    required String venue,
    required int span,
    required EventPaymentType type,
    @JsonKey(name: 'event_type') required EventType eventType,
    required int payment,
    @JsonKey(name: 'file_url') required String fileUrl,
    String? video,
    String? details,
    required bool subscribe,
    @JsonKey(name: 'total_subscribers') required int totalSubscribers,
  }) = _EventFileModel;

  EventFileModel._();

  factory EventFileModel.fromJson(Map<String, dynamic> json) => _$EventFileModelFromJson(json);
}