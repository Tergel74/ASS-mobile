import 'package:get/get.dart';

import '../modules/initial/view.dart';
import '../modules/initial/binding.dart';
import '../modules/auth/sign_in/view.dart';
import '../modules/auth/sign_in/binding.dart';

part 'routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.INITIAL;

  static final routes = [
    GetPage(
      name: _Paths.INITIAL,
      page: () => InitialView(),
      binding: InitialBinding(),
    ),
    GetPage(
      name: _Paths.SIGNIN,
      page: () => SignInView(),
      binding: SignInBinding(),
    ),
  ];
}
