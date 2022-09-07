import 'package:csean_mobile/domain/app_constants.dart';
import 'package:csean_mobile/domain/services/forum_service.dart';
import 'package:dio/dio.dart';

final Dio dio = Dio();

class ForumServiceImpl implements ForumService {
  @override
  Future<Response> getForums(String token) async {
    String url = '$baseUrl/forums';

    try {
      Response response = await dio.get(url, options: Options(headers: {"Authorization": "Bearer $token"}));
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<Response> getChapterForums(String token) async {
    String url = '$baseUrl/forums?privacy=1';

    try {
      Response response = await dio.get(url, options: Options(headers: {"Authorization": "Bearer $token"}));
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<Response> getTopicsFromId(int id, String token) async {
    String url = '$baseUrl/forum/topics?forum=$id';

    try {
      Response response = await dio.get(url, options: Options(headers: {"Authorization": "Bearer $token"}));
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<Response> getDiscussionsFromId(int id, String token) async {
    String url = '$baseUrl/forum/discussion?topic=$id';

    try {
      Response response = await dio.get(url, options: Options(headers: {"Authorization": "Bearer $token"}));
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<Response> sendMessage(int topicId, String message, String token) async {
    String url = "$baseUrl/forum/discussion?topic=$topicId";

    // TODO: Complete soon
    String fileUrl = "/forum/discussion?topic=$topicId&reply=replyId";

    Map<String, dynamic> body = {
      "message": message
    };

    try {
      Response response = await dio.post(url, data: body, options: Options(headers: {"Authorization": "Bearer $token"}));
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }
}