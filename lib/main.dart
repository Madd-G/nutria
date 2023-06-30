import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nutria/screen_controller.dart';
import 'firebase_options.dart';
import 'blocs/blocs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
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
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: const Color(0xff58D7B7),
          ),
        ),
        home: const ScreenController(),
      ),
    );
  }
}
