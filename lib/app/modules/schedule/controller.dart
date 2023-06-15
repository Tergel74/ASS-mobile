import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../data/repositories/repository.dart';

enum EventsStatus { empty, loading, completed }

class ScheduleController extends GetxController {
  final Repository _repo = Repository();
  final events = [].obs;
  final eventsStatus = EventsStatus.loading.obs;
  var selectedDate = DateTime.now().obs;

  getEventsByDate({required String date}) async {
    try {
      eventsStatus.value = EventsStatus.loading;
      final response = await _repo.getEventsByDate(date);
      events.value = response;
      events.isEmpty
          ? eventsStatus.value = EventsStatus.empty
          : eventsStatus.value = EventsStatus.completed;
    } on DioException catch (e) {
      final msg = e.response?.data['message'][0];
      print(e.response);
      Get.snackbar('Error', msg ?? 'Something went wrong',
          backgroundColor: Colors.deepPurple, colorText: Colors.white);
    }
  }
}
