import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import '../../../data/repositories/repository.dart';

enum QrStatus { detected, scanning, completed }

class QrController extends GetxController {
  final Repository _repo = Repository();
  final qrStatus = QrStatus.scanning.obs;

  checkInAttendanceQr(
      {required String qrString,
      required String eventId,
      required String date,
      required int timeDifference}) async {
    try {
      final response = await _repo.checkInAttendanceQr(
          qrString, eventId, date, timeDifference);
      if (response is DioException) {
        Get.back();
        Get.snackbar('Error',
            response.response?.data['message'] ?? 'Something went wrong',
            backgroundColor: Colors.deepPurple, colorText: Colors.white);
      } else {
        qrStatus.value = QrStatus.completed;
      }
    } on DioException catch (e) {
      final msg = e.response?.data['message'];
      print(e.response);
      Get.snackbar('Error', msg ?? 'Something went wrong',
          backgroundColor: Colors.deepPurple, colorText: Colors.white);
    }
  }
}
