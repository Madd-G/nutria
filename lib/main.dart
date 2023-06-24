import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nutria/blocs/bottom_nav_bar_bloc/bottom_nav_bar_bloc.dart';
import 'package:nutria/provider/chat_provider.dart';
import 'package:nutria/screen_controller.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
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
          create: (context) => ArticleBloc(),
        ),
        BlocProvider(
          lazy: true,
          create: (context) => ChatGPTBloc(),
        ),
        ChangeNotifierProvider(
          create: (_) => ChatProvider(),
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
