import 'package:csean_mobile/domain/app_constants.dart';
import 'package:csean_mobile/domain/services/events_service.dart';
import 'package:dio/dio.dart';

final Dio dio = Dio();

class EventsServiceImpl implements EventsService {
  @override
  Future<Response> getEvents(String token) async {
    String url = '$baseUrl/user/event';

    Response response = await dio.get(url, options: Options(headers: {"Authorization": "Bearer $token"}));

    return response;
  }

  @override
  Future<Response> getRegisteredEvents(String token) async {
    String url = '$baseUrl/user/event?sub=1';

    Response response = await dio.get(url, options: Options(headers: {"Authorization": "Bearer $token"}));

    return response;
  }

  @override
  Future<Response> registerForEvent(int id, String token) async {
    String url = '$baseUrl/event/subscribe';

    Map<String, dynamic> body = {"event": "$id"};

    Response response = await dio.post(url, data: body, options: Options(headers: {"Authorization": "Bearer $token"}));

    return response;
  }
}