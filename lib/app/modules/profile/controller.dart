import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../data/repositories/repository.dart';
import '../../../data/models/attendance_response.dart';

enum ProfileStatus { loading, completed }

class ProfileController extends GetxController {
  final Repository _repo = Repository();
  final profileStatus = ProfileStatus.loading.obs;
  final attendance = Rxn<AttendanceResponse>();

  @override
  void onInit() async {
    await getAttendance();
    profileStatus.value = ProfileStatus.completed;
    super.onInit();
  }

  getAttendance() async {
    try {
      final response = await _repo.getAttendance();
      attendance.value = response;
      profileStatus.value = ProfileStatus.completed;
    } on DioException catch (e) {
      final msg = e.response?.data['message'][0];
      print(e.response);
      Get.snackbar('Error', msg ?? 'Something went wrong',
          backgroundColor: Colors.deepPurple, colorText: Colors.white);
    }
  }
}
