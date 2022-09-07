import 'dart:io';

import 'package:dio/dio.dart';

abstract class ProgressTrackerService {
  Future<Response> getProgressData(String token);

  Future<Response> sendRequest(int activityId, String description, String dateCompleted, File certificate, String token);
}