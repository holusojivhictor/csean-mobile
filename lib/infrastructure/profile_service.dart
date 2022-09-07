import 'dart:io';

import 'package:http_parser/http_parser.dart';
import 'package:csean_mobile/domain/app_constants.dart';
import 'package:csean_mobile/domain/services/profile_service.dart';
import 'package:dio/dio.dart';
import 'infrastructure.dart';

class ProfileServiceImpl implements ProfileService {
  @override
  Future<Response> saveEdit(
    String firstName,
    String lastName,
    String phone,
    String membershipType,
    String currentOccupation,
    String jobTitle,
    String companyName,
    String address,
    String city,
    String country,
    String gender,
    String dateOfBirth,
    String token,
  ) async {
    String url = "$baseUrl/profile/update";

    Map<String, dynamic> body = {
      "membership_type": membershipType,
      "occupation": currentOccupation,
      "job_title": jobTitle,
      "company_name": companyName,
      "address": address,
      "city": city,
      "country": country,
      "gender": gender,
      "date_of_birth": dateOfBirth,
      "firstname": firstName,
      "lastname": lastName,
      "phone_number": phone,
    };

    Response response = await dio.post(url, data: body, options: Options(headers: {"Authorization": "Bearer $token"}));

    return response;
  }

  @override
  Future<void> updatePicture(File image, String token) async {
    String url = "$baseUrl/profile/update/photo";

    if (image.path.trim().isNotEmpty) {
      String fileName = image.path.split('/').last;
      FormData formData = FormData.fromMap({
        "photo": await MultipartFile.fromFile(image.path, filename: fileName, contentType: MediaType('image', 'jpg')),
      });

      await dio.post(url, data: formData, options: Options(headers: {"Authorization": "Bearer $token", "Accept": "application/json"}));
    } else {
      return;
    }
  }

  @override
  Future<Response> makeChapterChangeRequest(int chapterId, String token) async {
    String url = "$baseUrl/request/chapters";

    Map<String, int> body = {
      "chapter": chapterId,
    };

    Response response = await dio.post(url, data: body, options: Options(headers: {"Authorization": "Bearer $token", "Content-Type": "application/json"}));

    return response;
  }
}
