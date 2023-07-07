import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../schedule/view.dart';
import '../task/view.dart';
import '../profile/view.dart';

class HomeController extends GetxController {
  late PageController pageController;

  RxInt currentPage = 0.obs;

  List<Widget> pages = [ScheduleView(), TaskView(), ProfileView()];

  void goToPage(int page) {
    currentPage.value = page;
    pageController.jumpToPage(page);
  }

  void animateToPage(int page) {
    currentPage.value = page;
    pageController.animateToPage(page,
        duration: const Duration(microseconds: 300), curve: Curves.easeIn);
  }

  @override
  void onInit() {
    pageController = PageController(initialPage: 0);
    super.onInit();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
