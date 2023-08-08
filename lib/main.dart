import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nutria/screen_controller.dart';
import 'package:nutria/theme.dart';
import 'package:nutria/utils/custom_scroll/custom_scroll.dart';
import 'firebase_options.dart';
import 'blocs/blocs.dart';
import 'package:flutter/scheduler.dart';
import 'l10n/flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key, this.themeData, this.fakeHour = 10});

  ThemeData? themeData = ThemeData.dark();
  int? fakeHour;
  final osThemeIsLight =
      // SchedulerBinding.instance.window.platformBrightness == Brightness.light;
      SchedulerBinding.instance.platformDispatcher.platformBrightness ==
          Brightness.light;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // osThemeIsLight
        //     ? BlocProvider(
        //         create: (context) =>
        //             ThemeCubit(initialTheme: AppTheme.lightTheme),
        //       )
        //     : BlocProvider(
        //         create: (context) => ThemeCubit(
        //           initialTheme: AppTheme.darkTheme,
        //         ),
        //       ),
        BlocProvider(
          create: (context) => ThemeCubit(initialTheme: AppTheme.darkTheme),
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
        BlocProvider(
          lazy: true,
          create: (context) => NetworkBloc()..add(NetworkObserve()),
        ),
        BlocProvider(
          lazy: true,
          create: (context) => LanguageBloc()..add(GetLanguage()),
        ),
      ],
      child: Builder(
        builder: (context) {
          return BlocBuilder<LanguageBloc, LanguageState>(
            builder: (languageContext, state) {
              return MaterialApp(
                  scrollBehavior: MyCustomScrollBehavior(),
                  debugShowCheckedModeBanner: false,
                  theme: ThemeData.light(),
                  // theme: context.watch<ThemeCubit>().state,
                  // locale: state.selectedLanguage.value,
                  locale: const Locale('id', 'ID'),
                  supportedLocales: AppLocalizations.supportedLocales,
                  localizationsDelegates:
                      AppLocalizations.localizationsDelegates,
                  home: ScreenController(fakeHour: fakeHour));
            },
          );
        },
      ),
    );
  }
}
