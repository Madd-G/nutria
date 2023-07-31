import 'package:flutter/material.dart';
import 'package:nutria/responsive.dart';

typedef DialogOptionBuilder<T> = Map<String, T?> Function();

Future<T?> showGenericDialog<T>({
  required BuildContext context,
  required String title,
  required String content,
  required List<Widget> actions,
  // required VoidCallback onPressed,
}) {
  return showDialog<T>(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        title: Text(
          title,
          style: TextStyle(fontSize: Responsive.isMobile(context) ? 16.0 : 26.0),
        ),
        content: Text(
          content,
          style: TextStyle(fontSize: Responsive.isMobile(context) ? 14.0 : 22.0),
        ),
        actions: actions,
      );
    },
  );
}
