import '../../app/utils/auth_api_http_client.dart';
import '../../data/models/user_model.dart';

class AuthRepository {
  final client = AuthApiHttpClient();

  static const signInEndpoint = '/auth/login';
  static const refreshTokenEndpoint = '/auth/refresh';

  Future<dynamic> signIn(String email, String password) async {
    Users data = Users(email: email, password: password);
    return await client.post(signInEndpoint, data: data);
  }

  Future<dynamic> refreshToken(String refreshToken) async {
    return await client
        .post(refreshTokenEndpoint, data: {'refreshToken': refreshToken});
  }
}
