import 'package:dio/dio.dart';

abstract class ForumService {
  Future<Response> getForums(String token);

  Future<Response> getChapterForums(String token);

  Future<Response> getTopicsFromId(int id, String token);

  Future<Response> getDiscussionsFromId(int id, String token);

  Future<Response> sendMessage(int topicId, String message, String token);
}