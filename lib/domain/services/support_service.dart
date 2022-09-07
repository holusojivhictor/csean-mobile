import 'dart:io';

import 'package:dio/dio.dart';

abstract class SupportService {
  Future<Response> getSupportTickets(String token);

  Future<Response> submitTicket(String subject, String message, File? attachment, String token);
}