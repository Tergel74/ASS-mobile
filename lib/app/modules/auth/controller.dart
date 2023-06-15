import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import '../../services/local_storage.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../data/models/auth_response.dart';
import '../../../data/repositories/repository.dart';
import '../../../data/models/user_model.dart';

enum AuthStatus { authorized, loading, unauthorized }

class AuthController extends GetxController {
  final authStatus = AuthStatus.authorized.obs;
  final user = Rxn<Users>();

  final storage = Get.put(LocalStorageService(), permanent: true);
  final _auth = Get.put<AuthRepository>(AuthRepository());
  late Repository _repo;

  tokenInterval() async {
    Timer.periodic(const Duration(hours: 168), (timer) {
      checkToken();
    });
  }

  checkToken() async {
    if (authStatus.value != AuthStatus.authorized) {
      authStatus.value = AuthStatus.loading;
    }
    try {
      if (await storage.readData(StorageKey.accessToken) != null) {
        print('checking access token ...');
        _repo = Get.put<Repository>(Repository());
        final res = await _repo.getMe();
        user.value = res;
        authStatus.value = AuthStatus.authorized;
      } else {
        signOut();
      }
    } on Exception catch (e) {
      print(e);
      signOut();
    }
  }

  signOut() {
    storage.deleteData(StorageKey.accessToken);
    storage.deleteData(StorageKey.refreshToken);
    authStatus.value = AuthStatus.unauthorized;
  }

  signIn({required String email, required String password}) async {
    try {
      final response = await _auth.signIn(email, password);
      final responseBody = response.data;
      AuthResponse authResponse = AuthResponse.fromJson(responseBody);
      final accessToken = authResponse.accessToken;
      final refreshToken = authResponse.refreshToken;
      await storage.writeData(StorageKey.accessToken, accessToken);
      await storage.writeData(StorageKey.refreshToken, refreshToken);
      await checkToken();
      await tokenInterval();
      Get.put<Repository>(Repository());
    } on DioException catch (e) {
      final msg = e.response?.data['message'][0];
      print(e.response);
      Get.snackbar('Error', msg ?? 'Something went wrong',
          backgroundColor: Colors.deepPurple, colorText: Colors.white);
    }
  }

  Future<void> refreshToken() async {
    final refreshToken = await storage.readData(StorageKey.refreshToken);
    if (refreshToken == null) {
      signOut();
    }
    try {
      print(refreshToken);
      final response = await _auth.refreshToken(refreshToken);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseBody = response.data;
        AuthResponse authResponse = AuthResponse.fromJson(responseBody);
        final newAccessToken = authResponse.accessToken;
        final newRefreshToken = authResponse.refreshToken;
        await storage.writeData(StorageKey.accessToken, newAccessToken);
        await storage.writeData(StorageKey.refreshToken, newRefreshToken);
        checkToken();
      } else {
        signOut();
      }
    } on DioException catch (e) {
      print(e.response);
      final msg = e.response?.data['message'];
      Get.snackbar('Error', msg ?? 'Something went wrong',
          backgroundColor: Colors.deepPurple, colorText: Colors.white);
    }
  }
}
