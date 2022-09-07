import 'package:csean_mobile/domain/enums/enum.dart';

class EventCardModel {
  String get dateString => '$date $time';

  final int id;
  final int privacy;
  final int? chapterId;
  final String title;
  final int categoryId;
  final String date;
  final String time;
  final String venue;
  final EventPaymentType type;
  final EventType eventType;
  final int payment;
  final String? video;
  final bool subscribed;

  EventCardModel({
    required this.id,
    required this.privacy,
    required this.chapterId,
    required this.title,
    required this.categoryId,
    required this.date,
    required this.time,
    required this.venue,
    required this.type,
    required this.eventType,
    required this.payment,
    required this.video,
    required this.subscribed,
  });
}