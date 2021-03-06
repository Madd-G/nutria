import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nutria/views/camera_screen.dart';
import 'package:nutria/views/edit_profile_screen.dart';
import 'package:nutria/views/fruit_list_screen.dart';
import 'package:nutria/views/login_screen.dart';
import 'package:nutria/views/profile_screen.dart';
import 'package:nutria/views/sign_up_screen_first.dart';
import 'package:nutria/views/sign_up_screen_second.dart';
import 'package:nutria/views/splash_screen_first.dart';
import 'package:nutria/views/splash_screen_second.dart';
import 'package:nutria/views/upload_profile_photo_screen.dart';
import 'package:nutria/views/vegetable_list_screen.dart';
import 'package:nutria/views/home_screen.dart';
import 'views/screen_controller.dart';
import 'dictionary.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xff58D7B7),
        ),
      ),
      translations: Dictionary(),
      locale: const Locale('en_US', 'EN_US'),
      fallbackLocale: const Locale('en_US', 'EN_US'),
      home: const LoginScreen(),
      initialRoute: '/login_screen',
      getPages: [
        GetPage(
          name: '/',
          page: () => HomeScreen(),
        ),
        GetPage(
          name: '/splash_screen_first',
          page: () => const SplashScreenFirst(),
        ),
        GetPage(
          name: '/splash_screen_second',
          page: () => const SplashScreenSecond(),
        ),
        GetPage(
          name: '/login_screen',
          page: () => const LoginScreen(),
        ),
        GetPage(
          name: '/sign_up_screen_first',
          page: () => SignUpScreenFirst(),
        ),
        GetPage(
          name: '/sign_up_screen_second',
          page: () => const SignUpScreenSecond(),
        ),
        GetPage(
          name: '/upload_profile_photo_screen',
          page: () => const UploadProfilePhotoScreen(),
        ),
        GetPage(
          name: '/fruit_list_screen',
          page: () => FruitListScreen(),
        ),
        GetPage(
          name: '/vegetable_list_screen',
          page: () => const VegetableListScreen(),
        ),
        // GetPage(
        //     name: '/detail_screen',
        //     page: () => const DetailScreen(detailFruitVegetable: ,),),
        GetPage(
          name: '/profile_screen',
          page: () => ProfileScreen(),
        ),
        GetPage(
          name: '/edit_profile_screen',
          page: () => EditProfileScreen(),
        ),
        GetPage(
          name: '/camera_screen',
          page: () => const CameraScreen(),
        ),
        GetPage(
          name: '/screen_controller',
          page: () => ScreenController(),
        ),
      ],
    );
  }
}
