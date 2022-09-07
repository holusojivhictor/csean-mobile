import 'package:dio/dio.dart';

abstract class EventsService {
  Future<Response> getEvents(String token);

  Future<Response> getRegisteredEvents(String token);

  Future<Response> registerForEvent(int id, String token);
}