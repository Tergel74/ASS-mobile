import 'package:dio/dio.dart';
import '../models/qr_attendance_model.dart';
import '../models/user_model.dart';
import '../models/event_model.dart';
import '../models/attendance_response.dart';
import '../../app/utils/api_http_client.dart';

class Repository {
  final client = ApiHttpClient();

  static const String getMeEndpoint = '/user/me';
  static const String getEventsByDateEndpoint = '/events/getUserEventsByDate';
  static const String getOverallAttendanceEndpoint =
      '/attendance/getOverallAttendanceForUser';
  static const String checkInAttendanceQrEndpoint =
      '/attendance/checkInAttendanceQr';

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

  Future<dynamic> getAttendance() async {
    try {
      final response = await client.get(getOverallAttendanceEndpoint);
      AttendanceResponse attendance =
          AttendanceResponse.fromJson(response.data);
      return attendance;
    } on DioException catch (e) {
      print(e);
    }
  }

  Future<dynamic> checkInAttendanceQr(
      String qrString, String eventId, String date, int timeDifference) async {
    try {
      QrAttendance data = QrAttendance(
          qrString: qrString,
          eventId: eventId,
          date: date,
          timeDifference: timeDifference);
      final response =
          await client.post(checkInAttendanceQrEndpoint, data: data.toJson());
      return response.data;
    } on DioException catch (e) {
      return e;
    }
  }
}
