import 'dart:io';

import 'package:dio/dio.dart';

abstract class OnboardingService {
  Future<Response> submitAboutYou(String membershipType, int memberChapter, String occupation, String jobTitle, String token);

  Future<Response> submitEmployerDetails(String companyName, String address, String city, String country, String token);

  Future<Response> submitCertification(String licenseName, String dateIssued, File licenseDocument, String token);

  Future<Response> submitResume(File resumeDocument, String token);

  Future<Response> submitNewRefereeDetail(String refereeName, String refereeOccupation, String refereeEmail, String refereePhone, String refereeRelation, String token);

  Future<Response> submitEthicsStatus(int status, String token);
}
