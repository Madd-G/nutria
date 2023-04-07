import 'package:flutter/material.dart';
import 'package:nutria/utils/constants.dart';
import 'router.dart' as router;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xff58D7B7),
        ),
      ),
      initialRoute: homeRoute,
      onGenerateRoute: router.Router.generateRoute,
    );
  }
}
