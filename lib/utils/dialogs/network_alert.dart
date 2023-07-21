import 'dart:ui';
import 'package:flutter/material.dart' show BuildContext;
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
    onPressed: onPressed,
  );
}
