import 'dart:convert';
import 'dart:io';

import 'package:csean_mobile/domain/app_constants.dart';
import 'package:dio/dio.dart';
import 'package:csean_mobile/domain/services/onboarding_service.dart';
import 'infrastructure.dart';

class OnboardingServiceImpl implements OnboardingService {
  @override
  Future<Response> submitAboutYou(String membershipType, int memberChapter, String occupation, String jobTitle, String token) async {
    String url = "$baseUrl/enroll/form1";

    Map<String, dynamic> body = {
      "membership_type": membershipType,
      "chapter": memberChapter,
      "current_occupation": occupation,
      "job_title": jobTitle
    };

    Response response = await dio.post(url, data: jsonEncode(body), options: Options(headers: {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json"
    }));

    return response;
  }

  @override
  Future<Response> submitEmployerDetails(String companyName, String address, String city, String country, String token) async {
    String url = "$baseUrl/enroll/form2";

    Map<String, dynamic> body = {
      "company_name": companyName,
      "address": address,
      "city": city,
      "country": country
    };

    Response response = await dio.post(url, data: body, options: Options(headers: {"Authorization": "Bearer $token"}));

    return response;
  }

  @override
  Future<Response> submitCertification(String licenseName, String dateIssued, File licenseDocument, String token) async {
    String url = "$baseUrl/enroll/certificates";
    String fileName = licenseDocument.path.split('/').last;

    FormData formData = FormData.fromMap({
      "resume": await MultipartFile.fromFile(
        licenseDocument.path,
        filename: fileName,
      ),
      "certificate_title": licenseName,
      "date": dateIssued
    });

    Response response = await dio.post(url, data: formData, options: Options(headers: {"Authorization": "Bearer $token"}));

    return response;
  }

  @override
  Future<Response> submitResume(File resumeDocument, String token) async {
    String url = "$baseUrl/enroll/resume";
    String fileName = resumeDocument.path.split('/').last;

    FormData formData = FormData.fromMap({
      "resume": await MultipartFile.fromFile(
        resumeDocument.path,
        filename: fileName,
      ),
    });

    Response response = await dio.post(url, data: formData, options: Options(headers: {"Authorization": "Bearer $token"}));

    return response;
  }

  @override
  Future<Response> submitNewRefereeDetail(String refereeName, String refereeOccupation, String refereeEmail, String refereePhone, String refereeRelation, String token) async {
    String url = "$baseUrl/enroll/referrals";

    Map<String, dynamic> body = {
      "referrals": [
        {
          "full_name": refereeName,
          "occupation": refereeOccupation,
          "email": refereeEmail,
          "phoneNumber": int.parse(refereePhone),
          "relationship": refereeRelation
        }
      ]
    };

    Response response = await dio.post(url, data: jsonEncode(body), options: Options(headers: {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json"
    }));

    return response;
  }

  @override
  Future<Response> submitEthicsStatus(int status, String token) async {
    String url = "$baseUrl/enroll/ethics";

    Map<String, dynamic> body = {"ethics": "$status"};

    Response response = await dio.post(url, data: jsonEncode(body), options: Options(headers: {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json"
    }));

    return response;
  }
}