import 'package:csean_mobile/domain/enums/enum.dart';

class RequestCardModel {
  final int id;
  final int userId;
  final int activityId;
  final String title;
  final int point;
  final int totalPoints;
  final String completedAt;
  final ProgressRequestState requestState;

  RequestCardModel({
    required this.id,
    required this.userId,
    required this.activityId,
    required this.title,
    required this.point,
    required this.totalPoints,
    required this.completedAt,
    required this.requestState,
  });
}