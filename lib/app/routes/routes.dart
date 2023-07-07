part of 'pages.dart';

abstract class Routes {
  Routes._();
  static const INITIAL = _Paths.INITIAL;
  static const SIGNIN = _Paths.SIGNIN;
  static const SCHEDULE = _Paths.SCHEDULE;
  static const TASK = _Paths.TASK;
  static const PROFILE = _Paths.PROFILE;
  static const HOME = _Paths.HOME;
  static const SIGNUP = _Paths.SIGNUP;
  static const DAILYFORM = _Paths.DAILYFORM;
}

abstract class _Paths {
  _Paths._();
  static const INITIAL = '/initial';
  static const SIGNIN = '/signIn';
  static const SCHEDULE = '/schedule';
  static const TASK = '/task';
  static const PROFILE = '/profile';
  static const HOME = '/home';
  static const SIGNUP = '/signUp';
  static const DAILYFORM = '/dailyForm';
}
