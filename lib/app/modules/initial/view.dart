import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import 'package:iconly/iconly.dart';
import './controller.dart';
import '../auth/sign_in/view.dart';
import './components/loading_view.dart';
import '../auth/controller.dart';

class InitialView extends StatelessWidget {
  InitialView({super.key});

  final authController = Get.put<AuthController>(AuthController());
  final _initialController = Get.find<InitialController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => authController.authStatus.value == AuthStatus.loading
        ? const LoadingAnimation()
        : authController.authStatus.value == AuthStatus.unauthorized
            ? SignInView()
            : Scaffold(
                body: PageView(
                    controller: _initialController.pageController,
                    physics: const BouncingScrollPhysics(),
                    onPageChanged: _initialController.animateToPage,
                    children: [..._initialController.pages]),
                bottomNavigationBar: BottomAppBar(
                    child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                  child: Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _bottomAppBarItem(context,
                            icon: IconlyLight.calendar,
                            page: 0,
                            label: 'Schedule'),
                        _bottomAppBarItem(context,
                            icon: IconlyLight.tick_square,
                            page: 1,
                            label: 'Task'),
                        _bottomAppBarItem(context,
                            icon: IconlyLight.profile,
                            page: 2,
                            label: 'Profile'),
                      ],
                    ),
                  ),
                )),
              ));
  }

  Widget _bottomAppBarItem(BuildContext context,
      {required icon, required page, required label}) {
    return ZoomTapAnimation(
      onTap: () {
        _initialController.goToPage(page);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 20,
            color: _initialController.currentPage == page
                ? Colors.deepPurpleAccent
                : Colors.grey,
          ),
          Text(
            label,
            style: TextStyle(
                fontSize: 13,
                color: _initialController.currentPage == page
                    ? Colors.deepPurpleAccent
                    : Colors.grey,
                fontWeight: _initialController.currentPage == page
                    ? FontWeight.w600
                    : null),
          )
        ],
      ),
    );
  }
}
