import 'package:flutter/material.dart';
import 'package:nutria/responsive.dart';

typedef DialogOptionBuilder<T> = Map<String, T?> Function();

Future<T?> showGenericDialog<T>({
  required BuildContext context,
  required String title,
  required String content,
  required VoidCallback onPressed,
}) {
  return showDialog<T>(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        title: Text(
          title,
          style: TextStyle(fontSize: Responsive.isTablet(context) ? 24 : 20.0),
        ),
        content: Text(
          content,
          style: const TextStyle(fontSize: 18.0),
        ),
        actions: [
          TextButton(
            onPressed: onPressed,
            child: const Text(
              'OK',
              style: TextStyle(fontSize: 18.0),
            ),
          ),
        ],
      );
    },
  );
}
