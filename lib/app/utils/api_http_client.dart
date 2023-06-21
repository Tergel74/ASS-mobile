import 'package:dio/dio.dart';
import 'package:get/get.dart';
import '../services/local_storage.dart';
import '../modules/auth/controller.dart';

class ApiHttpClient {
  final storage = Get.find<LocalStorageService>();
  final authController = Get.find<AuthController>();
  // final dio = Dio(BaseOptions(
  //     baseUrl: 'http://192.168.1.81:5111/v1',
  //     headers: {'Content-Type': 'application/json'}));
  // final dio = Dio(BaseOptions(
  //     baseUrl: 'http://192.168.0.65:5111/v1',
  //     headers: {'Content-Type': 'application/json'}));
  // final dio = Dio(BaseOptions(
  //     baseUrl: 'http://10.0.2.2:5111/v1',
  //     headers: {'Content-Type': 'application/json'}));
  final dio = Dio(BaseOptions(
      baseUrl: 'https://lms.tomujin.digital/v1',
      headers: {'Content-Type': 'application/json'}));

  ApiHttpClient() {
    dio.interceptors.clear();
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (
          RequestOptions options,
          RequestInterceptorHandler handler,
        ) async {
          final accessToken = await storage.readData(StorageKey.accessToken);

          /// Add token to all requests.
          options.headers['Authorization'] = 'Bearer $accessToken';
          print('DIO is requesting: ${options.path}');
          return handler.next(options);
        },
        onError: (DioException error, ErrorInterceptorHandler handler) async {
          if (error.response == null) {
            return handler.next(error);
          }
          if (error.response?.statusCode == 401 ||
              error.response?.statusCode == 403) {
            try {
              print('----------Refreshing Token----------');
              await authController.refreshToken();
              print('----------Refreshed Token----------');
            } on Exception catch (e) {
              print(e);
              authController.signOut();
            }
          } else if (error.response?.statusCode == 500) {
            print('Internal Server Error!!');
            print(await storage.readData(StorageKey.accessToken));
            print(error.response?.requestOptions);
          }
          return handler.next(error);
        },
      ),
    );
  }

  Future<dynamic> get(String path, {Options? options}) {
    return dio.get(path, options: options);
  }

  Future<dynamic> post(String path, {data, Options? options}) {
    return dio.post(path, data: data, options: options);
  }
}
