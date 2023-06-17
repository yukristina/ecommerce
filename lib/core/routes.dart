import 'package:ecommerce/presentation/screens/auth/login_screen.dart';
import 'package:ecommerce/presentation/screens/auth/signup_screen.dart';
import 'package:flutter/cupertino.dart';

class Routes {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LoginScreen.routeName:
        return CupertinoPageRoute(builder: (context) => const LoginScreen());

      case SignUpScreen.routeName:
        return CupertinoPageRoute(builder: (context) => const SignUpScreen());

      default:
        return null;
    }
  }
}
