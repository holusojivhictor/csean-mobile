import 'package:csean_mobile/domain/app_constants.dart';
import 'package:csean_mobile/domain/services/resources_service.dart';
import 'package:dio/dio.dart';
import 'infrastructure.dart';

class ResourcesServiceImpl implements ResourcesService {
  @override
  Future<Response> getBlogs(String token) async {
    String url = '$baseUrl/blogs';

    Response response = await dio.get(url, options: Options(headers: {"Authorization": "Bearer $token"}));

    return response;
  }

  @override
  Future<Response> getResourcesCategories(String token) async {
    String url = '$baseUrl/learning/categories';

    Response response = await dio.get(url, options: Options(headers: {"Authorization": "Bearer $token"}));

    return response;
  }

  @override
  Future<Response> getSubcategoryItems(int categoryId, int subCategoryId, String token) async {
    String url = '$baseUrl/learning/resources?category=$categoryId&subcategory=$subCategoryId';

    Response response = await dio.get(url, options: Options(headers: {"Authorization": "Bearer $token"}));

    return response;
  }
}