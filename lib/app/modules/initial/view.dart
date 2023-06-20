import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../auth/sign_in/view.dart';
import '../../../widgets/loading_view.dart';
import '../auth/controller.dart';
import '../home/view.dart';

class InitialView extends StatelessWidget {
  InitialView({super.key});

  final authController = Get.put<AuthController>(AuthController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => authController.authStatus.value == AuthStatus.loading
        ? const Scaffold(body: LoadingAnimation())
        : authController.authStatus.value == AuthStatus.unauthorized
            ? SignInView()
            : const HomeView());
  }
}
