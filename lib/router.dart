import 'package:flutter/material.dart';
import 'package:nutria/screen_controller.dart';
import 'package:nutria/ui/home_screen/screen/home_screen.dart';
import 'package:nutria/ui/profile_screen/screen/profile_screen.dart';
import 'package:nutria/ui/scan_screen/screen/scan_screen.dart';
import 'package:nutria/utils/constants.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case screenControllerRoute:
        return MaterialPageRoute(builder: (_) => const ScreenController());
      case homeRoute:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case profileRoute:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case scanRoute:
        return MaterialPageRoute(builder: (_) => const ScanScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
