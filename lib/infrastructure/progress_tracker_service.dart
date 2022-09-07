import 'dart:io';

import 'package:csean_mobile/domain/app_constants.dart';
import 'package:csean_mobile/domain/services/services.dart';
import 'package:dio/dio.dart';
import 'infrastructure.dart';

class ProgressTrackerServiceImpl implements ProgressTrackerService {
  @override
  Future<Response> getProgressData(String token) async {
    String url = '$baseUrl/progress/requests';

    Response response = await dio.get(url, options: Options(headers: {"Authorization": "Bearer $token"}));

    return response;
  }

  @override
  Future<Response> sendRequest(int activityId, String description, String dateCompleted, File certificate, String token) async {
    String url = '$baseUrl/progress/requests';
    String fileName = certificate.path.split('/').last;

    FormData formData = FormData.fromMap({
      "activity": activityId,
      "note": description,
      "completed": dateCompleted,
      "file": await MultipartFile.fromFile(certificate.path, filename: fileName),
    });

    Response response = await dio.post(url, data: formData, options: Options(headers: {"Authorization": "Bearer $token"}));

    return response;
  }
}