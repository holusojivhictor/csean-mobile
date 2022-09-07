import 'package:csean_mobile/domain/assets.dart';
import 'package:csean_mobile/domain/enums/enum.dart';

class SubCategoryCardModel {
  String get desc => Assets.getResourceDescription(description);

  final int id;
  final int categoryId;
  final ResourceCategoryType categoryType;
  final String name;
  final String? description;

  SubCategoryCardModel({
    required this.id,
    required this.categoryId,
    required this.categoryType,
    required this.name,
    required this.description,
  });
}