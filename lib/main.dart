import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutria/blocs/auth_bloc/auth_bloc.dart';
import 'package:nutria/blocs/recommendations_bloc/recommendations_bloc.dart';
import 'package:nutria/screen_controller.dart';
import 'package:nutria/ui/login_screen/screen/login_screen.dart';
import 'package:nutria/ui/register_screen/screen/register_screen.dart';
import 'package:nutria/utils/dialogs/show_auth_error.dart';
import 'package:nutria/utils/loading/loading_screen.dart';
import 'blocs/screen_bloc/screen_bloc.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // HydratedBloc.storage = await HydratedStorage.build(
  //   storageDirectory: await getTemporaryDirectory(),
  // );
  runApp(const MyApp());
  // HydratedBlocOverrides.runZoned(
  //   () => runApp(const MyApp()),
  //   blocObserver: AppBlocObserver(),
  // );
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
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: const Color(0xff58D7B7),
          ),
        ),
        // initialRoute: loginRoute,
        // onGenerateRoute: router.Router.generateRoute,
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
