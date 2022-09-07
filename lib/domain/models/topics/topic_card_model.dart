import 'package:csean_mobile/domain/assets.dart';

class TopicCardModel {
  String get desc => Assets.getTopicDescription(description);

  final int id;
  final String name;
  final int creatorId;
  final int forumId;
  final String? description;
  final String profilePic;
  final String creatorName;
  final String dateCreated;

  TopicCardModel({
    required this.id,
    required this.name,
    required this.creatorId,
    required this.forumId,
    required this.description,
    required this.profilePic,
    required this.creatorName,
    required this.dateCreated,
  });
}