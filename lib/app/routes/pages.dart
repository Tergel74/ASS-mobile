import 'package:get/get.dart';

import '../modules/initial/view.dart';
import '../modules/initial/binding.dart';
import '../modules/auth/sign_in/view.dart';
import '../modules/auth/sign_in/binding.dart';
import '../modules/schedule/view.dart';
import '../modules/schedule/binding.dart';
import '../modules/profile/view.dart';
import '../modules/profile/binding.dart';
import '../modules/task/view.dart';
import '../modules/task/binding.dart';
import '../modules/home/view.dart';
import '../modules/home/binding.dart';
import '../modules/auth/sign_up/view.dart';
import '../modules/auth/sign_up/binding.dart';
import '../modules/daily_form/view.dart';
import '../modules/daily_form/binding.dart';

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
    GetPage(
      name: _Paths.SCHEDULE,
      page: () => ScheduleView(),
      binding: ScheduleBinding(),
    ),
    GetPage(
      name: _Paths.TASK,
      page: () => TaskView(),
      binding: TaskBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => SignUpView(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: _Paths.DAILYFORM,
      page: () => DailyFormView(),
      binding: DailyFormBinding(),
    ),
  ];
}
