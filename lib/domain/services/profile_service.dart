import 'dart:io';

import 'package:dio/dio.dart';

abstract class ProfileService {
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
  );

  Future<void> updatePicture(File image, String token);

  Future<Response> makeChapterChangeRequest(int chapterId, String token);
}
