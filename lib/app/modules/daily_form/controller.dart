import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../data/repositories/repository.dart';
import '../task/controller.dart';
import '../../../data/models/question_model.dart';

enum DailyFormStatus { success, error, ongoing }

class DailyFormController extends GetxController {
  final Repository _repo = Repository();
  final _taskController = Get.find<TaskController>();
  final dailyFormStatus = DailyFormStatus.ongoing.obs;

  final quote = ''.obs;

  answerForm(json) async {
    final dayNumber = DateTime.now().weekday;
    List questions = [];
    json.forEach((key, value) {
      if (value is double) {
        value = value.toInt();
      }
      Question questionAnswer =
          Question(id: key, dayNumber: dayNumber, answer: value);
      questions.add(questionAnswer.toJson());
    });
    try {
      final response =
          await _repo.answerForm(_taskController.form.value.id!, questions);
      if (response.data['status'] == 'OK') {
        dailyFormStatus.value = DailyFormStatus.success;
        _taskController.taskStatus.value = TaskStatus.disabled;
        quote.value = response.data['quote'];
        return response;
      } else {
        dailyFormStatus.value = DailyFormStatus.error;
      }
    } on DioException catch (e) {
      final msg = e.response?.data['message'][0];
      print(e.response);
      Get.snackbar('Error', msg ?? 'Something went wrong',
          backgroundColor: Colors.deepPurple, colorText: Colors.white);
    }
  }
}
