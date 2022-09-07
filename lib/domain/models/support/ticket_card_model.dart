import 'package:csean_mobile/domain/assets.dart';
import 'package:csean_mobile/domain/enums/enum.dart';

class TicketCardModel {
  String get assigned => Assets.getAssignedString(userAssigned);

  final int id;
  final String ticketKey;
  final String subject;
  final String message;
  final String createdAt;
  final SupportStageType supportStage;
  final String? userAssigned;

  TicketCardModel({
    required this.id,
    required this.ticketKey,
    required this.subject,
    required this.message,
    required this.createdAt,
    required this.supportStage,
    required this.userAssigned,
  });
}