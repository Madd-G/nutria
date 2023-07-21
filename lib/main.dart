import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nutria/screen_controller.dart';
import 'package:nutria/theme.dart';
import 'package:nutria/utils/custom_scroll/custom_scroll.dart';
import 'package:nutria/utils/utils.dart';
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
  MyApp({super.key});

  final osThemeIsLight =
      // SchedulerBinding.instance.window.platformBrightness == Brightness.light;
      SchedulerBinding.instance.platformDispatcher.platformBrightness ==
          Brightness.light;

  @override
  Widget build(BuildContext context) {
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
                  theme: context.watch<ThemeCubit>().state,
                  locale: state.selectedLanguage.value,
                  supportedLocales: AppLocalizations.supportedLocales,
                  localizationsDelegates:
                      AppLocalizations.localizationsDelegates,
                  home: BlocListener<NetworkBloc, NetworkState>(
                    listener: (context, state) {
                      print('<<<<<<<<<<< $state >>>>>>>>>>>');
                      if (state is NetworkFailure) {
                        AppLocalizations l10n = AppLocalizations.of(context)!;
                        showNetworkAlert(
                          context: context,
                          title: l10n.noInternetTitle,
                          content: l10n.noInternetAlert,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        );
                      }
                    },
                    child: const ScreenController(),
                  ));
            },
          );
        },
      ),
    );
  }
}
