import 'package:csean_mobile/domain/enums/enum.dart';

class ChapterCardModel {
  final int id;
  final ChapterType name;
  final String? description;
  final dynamic officers;
  final String? extra;

  ChapterCardModel({
    required this.id,
    required this.name,
    required this.description,
    required this.officers,
    required this.extra,
  });
}