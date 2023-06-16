import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../data/repositories/repository.dart';
import '../../../data/models/attendance_response.dart';

class ProfileController extends GetxController {
  final Repository _repo = Repository();
  final attendance = Rxn<AttendanceResponse>();

  @override
  void onInit() {
    getAttendance();
    super.onInit();
  }

  getAttendance() async {
    try {
      final response = await _repo.getAttendance();
      attendance.value = response;
    } on DioException catch (e) {
      final msg = e.response?.data['message'][0];
      print(e.response);
      Get.snackbar('Error', msg ?? 'Something went wrong',
          backgroundColor: Colors.deepPurple, colorText: Colors.white);
    }
  }
}
