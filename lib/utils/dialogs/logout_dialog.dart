import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nutria/l10n/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../responsive.dart';
import '../../ui/home_screen/widgets/widgets.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    double bottomSheetHeight = 340.0;
    final GoogleSignIn googleSignIn = GoogleSignIn();
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          builder: (context) {
            return SizedBox(
              height: bottomSheetHeight,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 25.0, 15.0, 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height:
                                (Responsive.isTablet(context)) ? 50.0 : 50.0,
                            width: (Responsive.isTablet(context)) ? 50.0 : 50.0,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(100.0),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                // FirebaseAuth.instance.currentUser!.displayName![0].toUpperCase(),
                                FirebaseAuth.instance.currentUser!.email![0]
                                    .toUpperCase(),
                                style: TextStyle(
                                    color: Colors.grey[200],
                                    fontSize: (Responsive.isTablet(context))
                                        ? 35
                                        : 30.0,
                                    // color: Colors.white,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 12.0,
                          ),
                          Text(
                            FirebaseAuth.instance.currentUser!.email!,
                            overflow: TextOverflow.fade,
                            style: TextStyle(
                                fontSize:
                                    Responsive.isTablet(context) ? 20.0 : 18.0),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 35.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.changeLanguage,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize:
                                  Responsive.isTablet(context) ? 20.0 : 18.0),
                        ),
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              barrierColor: Colors.transparent,
                              context: context,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20.0),
                                  topRight: Radius.circular(20.0),
                                ),
                              ),
                              builder: (context) {
                                return SizedBox(
                                  height: bottomSheetHeight,
                                  child: const LanguageBottomSheet(),
                                );
                              },
                            );
                          },
                          child: const Icon(
                            Icons.arrow_forward_ios,
                            size: 20.0,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.theme,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize:
                                  Responsive.isTablet(context) ? 20.0 : 18.0),
                        ),
                        const ThemeButton(),
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    GestureDetector(
                      onTap: () async {
                        await googleSignIn.signOut();
                        await FirebaseAuth.instance.signOut().then(
                              (value) =>
                                  ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(AppLocalizations.of(context)!
                                      .logoutSuccessfully),
                                ),
                              ),
                            );
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context);
                      },
                      child: Text(
                        AppLocalizations.of(context)!.logOut,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize:
                                Responsive.isTablet(context) ? 20.0 : 18.0),
                      ),
                    ),
                    const SizedBox(
                      height: 25.0,
                    ),
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
                      },
                      child: Text(
                        AppLocalizations.of(context)!.deleteAccount,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize:
                                Responsive.isTablet(context) ? 20.0 : 18.0,
                            color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      child: Container(
        height: (Responsive.isTablet(context)) ? 65.0 : 45.0,
        width: (Responsive.isTablet(context)) ? 65.0 : 45.0,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: const BorderRadius.all(
            Radius.circular(100.0),
          ),
        ),
        child: Center(
          child: Text(
            // FirebaseAuth.instance.currentUser!.displayName![0].toUpperCase(),
            FirebaseAuth.instance.currentUser!.email![0].toUpperCase(),
            style: TextStyle(
                fontSize: (Responsive.isTablet(context)) ? 35 : 25.0,
                color: Colors.grey[200],
                fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }
}