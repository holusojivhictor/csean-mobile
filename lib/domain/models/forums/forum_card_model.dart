import 'package:csean_mobile/domain/assets.dart';

class ForumCardModel {
  String get desc => Assets.getForumDescription(description, name, privacy);

  final int id;
  final String name;
  final String? description;
  final int? chapterId;
  final int privacy;

  ForumCardModel({
    required this.id,
    required this.name,
    required this.description,
    required this.chapterId,
    required this.privacy,
  });
}