import 'package:bass/data/models/form_model.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../data/repositories/repository.dart';

enum TaskStatus { loading, completed, disabled }

class TaskController extends GetxController {
  final Repository _repo = Repository();
  final taskStatus = TaskStatus.loading.obs;
  final form = Forms().obs;

  getForm() async {
    try {
      final response = await _repo.getForm();
      form.value = response;
      if (DateTime.parse(response.time).day.compareTo(DateTime.now().day) ==
          0) {
        taskStatus.value = TaskStatus.disabled;
      } else {
        taskStatus.value = TaskStatus.completed;
      }
    } on DioException catch (e) {
      final msg = e.response?.data['message'][0];
      print(e.response);
      Get.snackbar('Error', msg ?? 'Something went wrong',
          backgroundColor: Colors.deepPurple, colorText: Colors.white);
    }
  }
}
