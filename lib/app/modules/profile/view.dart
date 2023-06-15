import 'package:flutter/material.dart';
import '../auth/controller.dart';
import 'package:get/get.dart';

class ProfileView extends StatelessWidget {
  ProfileView({super.key});

  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF474a58),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.person,
              color: Colors.white,
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: authController.signOut,
              child: const Text('Log Out'),
            )
          ],
        ),
      ),
    );
  }
}
