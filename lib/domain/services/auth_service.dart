import 'package:csean_mobile/domain/models/network/api_result.dart';
import 'package:dio/dio.dart';

abstract class AuthService {
  Future<ApiResult<Response>> registerAccount(String firstName, String lastName, String email, String password, String passwordConfirmation);

  Future<ApiResult<Response>> login(String email, String password);

  Future<Response> getProfile(String token);
}