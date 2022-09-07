class BlogCardModel {
  final int id;
  final String title;
  final String content;
  final int authorId;
  final int categoryId;
  final String categoryName;
  final String createdAt;
  final String fileUrl;

  BlogCardModel({
    required this.id,
    required this.title,
    required this.content,
    required this.authorId,
    required this.categoryId,
    required this.categoryName,
    required this.createdAt,
    required this.fileUrl,
  });
}