import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nutria/utils/utils.dart';
import '../../l10n/flutter_gen/gen_l10n/app_localizations.dart';

Future<void> showDeleteAccountAlert({
  required BuildContext context,
  required String title,
  required String content,
}) {
  return showGenericDialog<void>(
    context: context,
    title: title,
    content: content,
    actions: [
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () async {
                await FirebaseAuth.instance.currentUser!.delete().then(
                      (value) =>
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(AppLocalizations.of(context)!
                              .deletedSuccessfully),
                        ),
                      ),
                );
                // ignore: use_build_context_synchronously
                Navigator.pop(context);
                // ignore: use_build_context_synchronously
                Navigator.pop(context);
              },
              child: Text(
                AppLocalizations.of(context)!.yes,
                style: const TextStyle(fontSize: 18.0),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Text(
                AppLocalizations.of(context)!.no,
                style: const TextStyle(fontSize: 18.0),
              ),
            )
          ],
        ),
      ),
    ],
    // onPressed: onPressed,
  );
}
