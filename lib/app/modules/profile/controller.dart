import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../data/repositories/repository.dart';
import '../../../data/models/attendance_response.dart';

enum ProfileStatus { loading, completed }

enum AttendanceListStatus { loading, empty, completed }

class ProfileController extends GetxController {
  final Repository _repo = Repository();
  final profileStatus = ProfileStatus.loading.obs;
  final attendanceListStatus = AttendanceListStatus.loading.obs;
  final attendance = Rxn<AttendanceResponse>();
  final attendanceList = [].obs;

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

  getAttendanceForStatus({required String status}) async {
    try {
      attendanceListStatus.value = AttendanceListStatus.loading;
      final response = await _repo.getAttendanceForStatus(status);
      attendanceList.value = response;
      attendanceList.isEmpty
          ? attendanceListStatus.value = AttendanceListStatus.empty
          : attendanceListStatus.value = AttendanceListStatus.completed;
    } on DioException catch (e) {
      final msg = e.response?.data['message'][0];
      print(e.response);
      Get.snackbar('Error', msg ?? 'Something went wrong',
          backgroundColor: Colors.deepPurple, colorText: Colors.white);
    }
  }
}
