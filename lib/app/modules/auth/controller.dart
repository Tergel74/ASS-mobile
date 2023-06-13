import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../services/local_storage.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../data/models/responses/auth_response.dart';
import '../initial/controller.dart';

class AuthController extends GetxController {
  final storage = Get.put(LocalStorageService(), permanent: true);
  final _auth = Get.put<AuthRepository>(AuthRepository());

  signIn({required String email, required String password}) async {
    try {
      final response = await _auth.signIn(email, password);
      print(response.data);
      final responseBody = response.data;
      AuthResponse authResponse = AuthResponse.fromJson(responseBody);
      final accessToken = authResponse.accessToken;
      final refreshToken = authResponse.refreshToken;
      await storage.writeData(StorageKey.accessToken, accessToken);
      await storage.writeData(StorageKey.refreshToken, refreshToken);
      Get.put<InitialController>(InitialController());
    } on DioException catch (e) {
      final msg = e.response?.data['message'][0];
      print(e.response);
      Get.snackbar('Error', msg ?? 'Something went wrong',
          backgroundColor: Colors.deepPurple, colorText: Colors.white);
    }
  }
}
