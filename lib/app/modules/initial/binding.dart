import 'package:get/get.dart';
import 'controller.dart';
import '../home/controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => InitialController());
    Get.lazyPut(() => HomeController());
  }
}
