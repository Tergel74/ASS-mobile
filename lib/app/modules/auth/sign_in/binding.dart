import 'package:get/get.dart';
import '../../auth/sign_in/controller.dart';

class SignInBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignInController());
  }
}
