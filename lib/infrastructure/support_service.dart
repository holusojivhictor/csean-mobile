import 'dart:io';

import 'package:csean_mobile/domain/app_constants.dart';
import 'package:csean_mobile/domain/services/services.dart';
import 'package:dio/dio.dart';

import 'infrastructure.dart';

class SupportServiceImpl implements SupportService {
  @override
  Future<Response> getSupportTickets(String token) async {
    String url = "$baseUrl/support";

    Response response = await dio.get(url, options: Options(headers: {"Authorization": "Bearer $token"}));

    return response;
  }

  @override
  Future<Response> submitTicket(String subject, String message, File? attachment, String token) async {
    String url = "$baseUrl/support";
    FormData formData;

    if (attachment != null) {
      String fileName = attachment.path.split('/').last;

      formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(
          attachment.path,
          filename: fileName,
        ),
        "subject": subject,
        "message": message
      });
    } else {
      formData = FormData.fromMap({
        "subject": subject,
        "message": message
      });
    }

    Response response = await dio.post(url, data: formData, options: Options(headers: {"Authorization": "Bearer $token"}));

    return response;
  }

}