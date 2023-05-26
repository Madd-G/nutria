import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nutria/screen_controller.dart';
import 'package:nutria/utils/dialogs/dialogs.dart';
import 'package:nutria/utils/loading/loading_screen.dart';
import 'firebase_options.dart';
import 'ui/screens.dart';
import 'blocs/blocs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          lazy: true,
          create: (context) => AuthBloc()..add(const AuthEventInitial()),
        ),
        BlocProvider(
          lazy: true,
          create: (context) => ScreenBloc(),
        ),
        BlocProvider(
          lazy: true,
          create: (context) => RecommendationsBloc(),
        ),
        BlocProvider(
          lazy: true,
          create: (context) => PredictionBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: const Color(0xff58D7B7),
          ),
        ),
        home: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthStateLoggedIn) {
              context.read<ScreenBloc>().add(
                    ScreenEventGoToScreenController(),
                  );
            }
            if (state is AuthStateLoggedOut) {
              context.read<ScreenBloc>().add(
                    ScreenEventGoToLoginScreen(),
                  );
            }
            if (state.isLoading) {
              LoadingScreen.instance().show(
                context: context,
                text: 'Loading...',
              );
            } else {
              LoadingScreen.instance().hide();
            }
            final authError = state.authError;
            if (authError != null) {
              showAuthError(
                authError: authError,
                context: context,
              );
            }
          },
          child: BlocBuilder<ScreenBloc, ScreenState>(
            builder: (context, screenState) {
              if (kDebugMode) {
                print('Screen State $screenState');
              }
              if (screenState is ScreenStateIsInLoginScreen) {
                return const LoginScreen();
              } else if (screenState is ScreenStateIsInRegistrationScreen) {
                return const RegisterScreen();
              } else if (screenState is ScreenStateIsInScreenController) {
                return const ScreenController();
              } else if (screenState is ScreenStateIsInHomeScreen) {
                return const ScreenController();
              } else if (screenState is ScreenStateIsInScanScreen) {
                return const ScreenController();
              } else if (screenState is ScreenStateIsInProfileScreen) {
                return const ScreenController();
              } else if (screenState is ScreenStateIsInUserDataScreen) {
                return const UserDataScreen();
              } else if (screenState is ScreenStateIsInChangePasswordScreen) {
                return const ChangePasswordScreen();
              } else {
                // this should never happen
                return const Scaffold(
                  body: Center(
                    child: Text('Home builder error'),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
