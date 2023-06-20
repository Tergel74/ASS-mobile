import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'controller.dart';
import '../auth/controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _homeController = Get.find<HomeController>();
  final _authController = Get.find<AuthController>();

  final userGenderForProfileIcon = {
    'male': MdiIcons.faceManProfile,
    'female': MdiIcons.faceWomanProfile
  };

  @override
  void initState() {
    _homeController.currentPage.value = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
          controller: _homeController.pageController,
          physics: const BouncingScrollPhysics(),
          onPageChanged: _homeController.animateToPage,
          children: [..._homeController.pages]),
      bottomNavigationBar: BottomAppBar(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
        child: Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _bottomAppBarItem(context,
                  icon: MdiIcons.calendarBadge, page: 0, label: 'Schedule'),
              _bottomAppBarItem(context,
                  icon: Icons.task, page: 1, label: 'Task'),
              _bottomAppBarItem(context,
                  icon: userGenderForProfileIcon[
                      _authController.user.value?.gender],
                  page: 2,
                  label: 'Profile'),
            ],
          ),
        ),
      )),
    );
  }

  Widget _bottomAppBarItem(BuildContext context,
      {required icon, required page, required label}) {
    return ZoomTapAnimation(
      onTap: () {
        _homeController.goToPage(page);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 20,
            color: _homeController.currentPage == page
                ? Colors.deepPurple
                : Colors.grey,
          ),
          Text(
            label,
            style: TextStyle(
                fontSize: 13,
                color: _homeController.currentPage == page
                    ? Colors.deepPurple
                    : Colors.grey,
                fontWeight: _homeController.currentPage == page
                    ? FontWeight.w600
                    : null),
          )
        ],
      ),
    );
  }
}
