import 'package:csean_mobile/domain/enums/enum.dart';

class ResourceItemCardModel {
  final int id;
  final int categoryId;
  final int subCategoryId;
  final String title;
  final ResourceType type;
  final String description;
  final int fileSize;
  final String createdAt;
  final String fileUrl;
  final bool isDownloaded;

  ResourceItemCardModel({
    required this.id,
    required this.categoryId,
    required this.subCategoryId,
    required this.title,
    required this.type,
    required this.description,
    required this.fileSize,
    required this.createdAt,
    required this.fileUrl,
    required this.isDownloaded,
  });
}