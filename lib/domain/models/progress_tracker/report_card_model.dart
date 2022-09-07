class ReportCardModel {
  final int totalPoints;
  final int remainingPoints;
  final int pending;
  final int approved;
  final int declined;

  ReportCardModel({
    required this.totalPoints,
    required this.remainingPoints,
    required this.pending,
    required this.approved,
    required this.declined,
  });
}