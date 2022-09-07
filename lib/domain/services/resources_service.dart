import 'package:dio/dio.dart';

abstract class ResourcesService {
  Future<Response> getBlogs(String token);

  Future<Response> getResourcesCategories(String token);

  Future<Response> getSubcategoryItems(int categoryId, int subCategoryId, String token);
}