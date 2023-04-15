import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:nutria/blocs/recommendations_bloc/recommendations_bloc.dart';
import 'package:nutria/utils/constants.dart';
import 'blocs/app_bloc_observer.dart';
import 'blocs/screen_bloc/screen_bloc.dart';
import 'router.dart' as router;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBlocOverrides.runZoned(
    () => runApp(const MyApp()),
    blocObserver: AppBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          lazy: false,
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
        initialRoute: screenControllerRoute,
        onGenerateRoute: router.Router.generateRoute,
      ),
    );
  }
}
