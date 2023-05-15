import 'package:flutter/material.dart';
import 'package:nutria/screen_controller.dart';
import 'package:nutria/utils/constants.dart';
import 'ui/screen_imports.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case screenControllerRoute:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const ScreenController());
      case homeRoute:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const HomeScreen());
      case profileRoute:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const ProfileScreen());
      case scanRoute:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const ScanScreen());
      case registrationRoute:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const RegisterScreen());
      case loginRoute:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const LoginScreen());
      default:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
