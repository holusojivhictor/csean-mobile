import 'package:csean_mobile/domain/app_constants.dart';
import 'package:csean_mobile/domain/services/services.dart';
import 'package:csean_mobile/infrastructure/infrastructure.dart';
import 'package:dio/dio.dart';

class PaymentServiceImpl implements PaymentService {
  @override
  Future<Response> fetchAccessCode(String token) async {
    String url = "$baseUrl/member/subscribtion";

    Map<String, dynamic> data = {};

    Response response = await dio.post(url, data: data, options: Options(headers: {"Authorization": "Bearer $token"}));

    return response;
  }

  @override
  Future<Response> fetchAccessCodeForEvent(int id, String token) async {
    String url = "$baseUrl/event/payment";

    Map<String, dynamic> data = {
      "event": id,
    };

    Response response = await dio.post(url, data: data, options: Options(headers: {"Authorization": "Bearer $token"}));

    return response;
  }

  @override
  Future<Response> verifyTransaction(String reference, String token) async {
    String url = "$baseUrl/links/member/subscribtion?reference=$reference";

    Response response = await dio.get(url, options: Options(headers: {"Authorization": "Bearer $token"}));

    return response;
  }

  @override
  Future<Response> verifyEventTransaction(String reference, String token) async {
    String url = "$baseUrl/links/event/payment?reference=$reference";

    Response response = await dio.get(url, options: Options(headers: {"Authorization": "Bearer $token"}));

    return response;
  }

  @override
  Future<Response> getTransactionHistory(String token) async {
    String url = "$baseUrl/payment/history/subscribtion";

    Response response = await dio.get(url, options: Options(headers: {"Authorization": "Bearer $token"}));

    return response;
  }

  @override
  Future<Response> getEventsTransactionHistory(String token) async {
    String url = "$baseUrl/payment/history/events";

    Response response = await dio.get(url, options: Options(headers: {"Authorization": "Bearer $token"}));

    return response;
  }
}