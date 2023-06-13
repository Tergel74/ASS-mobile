import 'package:get/get.dart';
import '../controller.dart';

class SignInController extends GetxController {
  final authController = Get.find<AuthController>();

  Future<void> signIn(String email, String password) async {
    await authController.signIn(email: email, password: password);
  }
}
