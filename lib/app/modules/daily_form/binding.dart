import 'package:get/get.dart';
import 'controller.dart';

class DailyFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DailyFormController());
  }
}
