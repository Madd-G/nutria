import 'package:flutter/material.dart';
import 'package:nutria/utils/utils.dart';

Future<void> showNetworkAlert({
  required BuildContext context,
  required String title,
  required String content,
  required VoidCallback onPressed,
}) {
  return showGenericDialog<void>(
    context: context,
    title: title,
    content: content,
    actions: [
      TextButton(
        onPressed: onPressed,
        child: const Text(
          'OK',
          style: TextStyle(fontSize: 18.0),
        ),
      ),
    ],
    // onPressed: onPressed,
  );
}
