import 'package:csean_mobile/domain/enums/enum.dart';

class ActivityCardModel {
  final int id;
  final String title;
  final ProgressActivityType activityType;
  final int point;
  final String createdAt;
  final bool accepted;
  final bool isSubmitted;

  ActivityCardModel({
    required this.id,
    required this.title,
    required this.activityType,
    required this.point,
    required this.createdAt,
    required this.accepted,
    required this.isSubmitted,
  });
}