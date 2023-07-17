import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nutria/screen_controller.dart';
import 'package:nutria/theme.dart';
import 'package:nutria/utils/controller/language_controller.dart';
import 'package:path_provider/path_provider.dart';
import 'dictionary.dart';
import 'firebase_options.dart';
import 'blocs/blocs.dart';
import 'package:flutter/scheduler.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:get/get.dart';

// Apple provider
// https://nutria-f8872.firebaseapp.com/__/auth/handler

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  // final storage = await HydratedStorage.build(
  //   storageDirectory: kIsWeb
  //       ? HydratedStorage.webStorageDirectory
  //       : await getApplicationDocumentsDirectory(),
  // );

  // HydratedBlocOverrides.runZoned(
  //       () => runApp(MyApp()),
  //   storage: storage,
  //   blocObserver: AppBlocObserver(),
  // );
  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: await getTemporaryDirectory());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final osThemeIsLight =
      // SchedulerBinding.instance.window.platformBrightness == Brightness.light;
      SchedulerBinding.instance.platformDispatcher.platformBrightness ==
          Brightness.light;

  @override
  Widget build(BuildContext context) {
    final languageController = Get.put(LanguageController());
    final cont = languageController.locale;
    return MultiBlocProvider(
      providers: [
        osThemeIsLight
            ? BlocProvider(
                create: (context) =>
                    ThemeCubit(initialTheme: AppTheme.lightTheme),
              )
            : BlocProvider(
                create: (context) => ThemeCubit(
                  initialTheme: AppTheme.darkTheme,
                ),
              ),
        BlocProvider(
          lazy: true,
          create: (context) => PredictionBloc(),
        ),
        BlocProvider(
          lazy: true,
          create: (context) => AuthCubit(),
        ),
        BlocProvider(
          lazy: true,
          create: (context) => TabBloc(),
        ),
        BlocProvider(
          lazy: true,
          create: (context) => BottomNavBarBloc(),
        ),
        BlocProvider(
          lazy: true,
          create: (context) => ChatGPTBloc(),
        ),
      ],
      child: Builder(builder: (context) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: context.watch<ThemeCubit>().state,
          translations: Dictionary(),
          locale: languageController.locale,
          fallbackLocale: const Locale('en_US', 'EN_US'),
          home: const ScreenController(),
        );
      }),
    );
  }
}
