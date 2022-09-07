class TrackerCardModel {
  final int id;
  final int adminId;
  final int targetPoint;
  final int targetPeriod;
  final String targetTimeline;

  TrackerCardModel({
    required this.id,
    required this.adminId,
    required this.targetPoint,
    required this.targetPeriod,
    required this.targetTimeline,
  });
}