import 'package:get/get.dart';
import '../controller.dart';

class SignUpController extends GetxController {
  final authController = Get.find<AuthController>();

  Future<void> signUp(
      String firstName, String lastName, String email, String password) async {
    await authController.signUp(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password);
  }
}
