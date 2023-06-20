import 'dart:async';
import 'package:dio/dio.dart';

class AuthApiHttpClient {
  // final dio = Dio(BaseOptions(
  //     baseUrl: 'https://lms.tomujin.digital/v1',
  //     headers: {'Content-Type': 'application/json'}));
  final dio = Dio(BaseOptions(
      baseUrl: 'http://192.168.0.65:5111/v1',
      headers: {'Content-Type': 'application/json'}));
  // final dio = Dio(BaseOptions(
  //     baseUrl: 'http://10.0.2.2:5111/v1',
  //     headers: {'Content-Type': 'application/json'}));

  Future<dynamic> post(String path, {data}) {
    return dio.post(
      path,
      data: data,
    );
  }

  Future<dynamic> get(String path) {
    return dio.get(path);
  }

  AuthApiHttpClient() {
    dio.interceptors.clear();
    dio.interceptors.add(
      QueuedInterceptorsWrapper(
        onResponse: (
          Response<dynamic> response,
          ResponseInterceptorHandler handler,
        ) async {
          if (response.data['error'] != null) {
            return handler.reject(
              DioException(
                requestOptions: response.requestOptions,
                response: response,
                // need attention
                // type: DioExceptionType.unknown,
              ),
            );
          }
          return handler.resolve(response);
        },
      ),
    );
  }
}
