import 'package:dio/dio.dart';
import '../models/user_model.dart';
import '../models/event_model.dart';
import '../../app/utils/api_http_client.dart';

class Repository {
  final client = ApiHttpClient();

  static const String getMeEndpoint = '/user/me';
  static const String getEventsByDateEndpoint = '/events/getUserEventsByDate';

  Future<dynamic> getMe() async {
    try {
      final response = await client.get(getMeEndpoint);
      Users me = Users.fromJson(response.data);
      return me;
    } on DioException catch (e) {
      print(e);
    }
  }

  Future<dynamic> getEventsByDate(String date) async {
    try {
      Event data = Event(date: date);
      final response =
          await client.post(getEventsByDateEndpoint, data: data.toJson());
      List events =
          List<Event>.from(response.data.map((model) => Event.fromJson(model)));
      return events;
    } on DioException catch (e) {
      print(e);
    }
  }
}
