import 'package:flutter/material.dart';
import 'package:nutria/screen_controller.dart';
import 'package:nutria/ui/home_screen/screen/home_screen.dart';
import 'package:nutria/ui/profile_screen/screen/profile_screen.dart';
import 'package:nutria/ui/scan_screen/screen/scan_screen.dart';
import 'package:nutria/utils/constants.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    print('settings.name: ${settings.name}');
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
