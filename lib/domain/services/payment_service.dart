import 'package:dio/dio.dart';

abstract class PaymentService {
  Future<Response> fetchAccessCode(String token);

  Future<Response> fetchAccessCodeForEvent(int id, String token);

  Future<Response> verifyTransaction(String reference, String token);

  Future<Response> verifyEventTransaction(String reference, String token);

  Future<Response> getTransactionHistory(String token);

  Future<Response> getEventsTransactionHistory(String token);
}