import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nutria/responsive.dart';
import 'package:nutria/utils/utils.dart';
import '../../l10n/flutter_gen/gen_l10n/app_localizations.dart';

Future<void> showLogoutAlert({
  required BuildContext context,
  required String title,
  required String content,
  // required VoidCallback onPressed,
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
              onTap: () {
                Navigator.pop(context);
              },
              child: Text(
                AppLocalizations.of(context)!.no,
                style: TextStyle(
                    fontSize: Responsive.isMobile(context) ? 12.0 : 18.0),
              ),
            ),
            GestureDetector(
              onTap: () async {
                final GoogleSignIn googleSignIn = GoogleSignIn();
                await googleSignIn.signOut();
                await FirebaseAuth.instance.signOut().then(
                      (value) => ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              AppLocalizations.of(context)!.logoutSuccessfully),
                        ),
                      ),
                    );
                // ignore: use_build_context_synchronously
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Text(
                AppLocalizations.of(context)!.yes,
                style: TextStyle(
                  fontSize: Responsive.isMobile(context) ? 12.0 : 18.0,
                ),
              ),
            ),
          ],
        ),
      ),
    ],
    // onPressed: onPressed,
  );
}
