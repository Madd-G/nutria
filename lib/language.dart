import 'package:flutter/cupertino.dart';

enum Language {
  english(
    Locale('en', 'US'),
    AssetImage('assets/images/english.png'),
    'English'
  ),
  indonesia(
    Locale('id', 'ID'),
    AssetImage('assets/images/indonesia.png'),
    'Indonesia'
  );

  /// Add another languages support here
  const Language(this.value, this.image, this.text);

  final Locale value;
  final AssetImage image;
  final String text;
}
