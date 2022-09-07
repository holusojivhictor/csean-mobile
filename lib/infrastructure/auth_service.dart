import 'package:csean_mobile/domain/app_constants.dart';
import 'package:csean_mobile/domain/models/network/api_result.dart';
import 'package:csean_mobile/domain/models/network/network_exceptions.dart';
import 'package:csean_mobile/domain/services/auth_service.dart';
import 'package:dio/dio.dart';
import 'infrastructure.dart';

class AuthServiceImpl implements AuthService {

  @override
  Future<ApiResult<Response>> registerAccount(String firstName, String lastName, String email, String password, String passwordConfirmation) async {
    // TODO: Get typo fixed
    String url = "$baseUrl/auth/registeration";
    Map<String, dynamic> body = {
      "firstname": firstName,
      "lastname": lastName,
      "email": email,
      "password": password,
      "password_confirmation": passwordConfirmation,
    };

    try {
      final Response response = await dio.post(url, data: body);
      return ApiResult.success(data: response);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<Response>> login(String email, String password) async {
    String url = "$baseUrl/auth/login";
    Map<String, dynamic> body = {
      "email": email,
      "password": password,
    };

    try {
      final Response response = await dio.post(url, data: body);
      return ApiResult.success(data: response);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<Response> getProfile(String token) async {
    String url = "$baseUrl/profile";

    final Response response = await dio.get(url, options: Options(headers: {"Authorization": "Bearer $token"}));
    return response;
  }
}