part of 'pages.dart';

abstract class Routes {
  Routes._();
  static const INITIAL = _Paths.INITIAL;
  static const SIGNIN = _Paths.SIGNIN;
}

abstract class _Paths {
  _Paths._();
  static const INITIAL = '/initial';
  static const SIGNIN = '/signIn';
}
