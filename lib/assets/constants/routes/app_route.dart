import 'package:firebase_exam_demo/assets/constants/route_names/route_names.dart';
import 'package:firebase_exam_demo/core/presentation/pages/login_screen.dart';
import 'package:firebase_exam_demo/core/presentation/pages/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppRoute {
  static Route? onGenerateRoute(RouteSettings settings) {
    final String routeName = settings.name ?? '/';


    switch (routeName) {
      case AppRouteNames.splashScreen:
        return CupertinoPageRoute(builder: (context) => const SplashScreen());
      case AppRouteNames.loginScreen:
        return CupertinoPageRoute(builder: (context) => const LoginScreen());
      // case AppRouteNames.onBoarding:
      //   return CupertinoPageRoute(builder: (context) => const OnBoarding());
      default:
        return CupertinoPageRoute(builder: (context) => const Scaffold());
    }
  }
}

