import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
      // fontFamily: 'Poppins',
      colorScheme: const ColorScheme.light().copyWith(
        background: Colors.white,
        primary: const Color(0xff58D7B7),
        secondary: Colors.black,
        onPrimary: const Color(0xff58D7B7),
        onSecondary: Colors.white.withOpacity(0.5),
        onPrimaryContainer: Colors.white,
        onSecondaryContainer: Colors.white,
      ),
      textTheme:
          const TextTheme(labelMedium: TextStyle(color: Color(0xff58D7B7))));

  static final ThemeData darkTheme = ThemeData.dark().copyWith(
      colorScheme: ColorScheme.fromSwatch().copyWith(
          background: const Color(0xff1F212F),
          primary: const Color(0xff1F212F),
          secondary: const Color(0xff131525),
          onPrimary: Colors.white,
          onSecondary: Colors.grey,
          onPrimaryContainer: Colors.white,
          onSecondaryContainer: Colors.white30),
      textTheme: const TextTheme(labelMedium: TextStyle(color: Colors.white)));
}
