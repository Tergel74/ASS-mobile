import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../auth/sign_in/view.dart';
import '../auth/controller.dart';

class InitialView extends StatelessWidget {
  InitialView({super.key});

  final authController = Get.put<AuthController>(AuthController());

  @override
  Widget build(BuildContext context) {
    return SignInView();
  }
}
