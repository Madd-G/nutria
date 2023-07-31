import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nutria/l10n/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../responsive.dart';
import '../../ui/home_screen/widgets/widgets.dart';
import 'dialogs.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    double bottomSheetHeight = 350.0;
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
                            height: 50.0,
                            width: 50.0,
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
                                    fontSize: (Responsive.isMobile(context))
                                        ? 30.0
                                        : 35.0,
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
                                    Responsive.isMobile(context) ? 14.0 : 20.0),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Responsive.isMobile(context) ? 25.0 : 35,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.changeLanguage,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize:
                                  Responsive.isMobile(context) ? 14.0 : 20.0),
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
                    SizedBox(
                      height: Responsive.isMobile(context) ? 10.0 : 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.theme,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize:
                                  Responsive.isMobile(context) ? 14.0 : 20.0),
                        ),
                        const ThemeButton(),
                      ],
                    ),
                    SizedBox(
                      height: Responsive.isMobile(context) ? 10.0 : 20.0,
                    ),
                    GestureDetector(
                      onTap: () async {
                        showLogoutAlert(
                          context: context,
                          title: AppLocalizations.of(context)!.logOut,
                          content: AppLocalizations.of(context)!.confirmLogout,
                        );
                      },
                      child: Text(
                        AppLocalizations.of(context)!.logOut,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize:
                                Responsive.isMobile(context) ? 14.0 : 20.0),
                      ),
                    ),
                    SizedBox(
                      height: Responsive.isMobile(context) ? 15.0 : 20.0,
                    ),
                    GestureDetector(
                      onTap: () async {
                        showDeleteAccountAlert(
                          context: context,
                          title: AppLocalizations.of(context)!.deleteAccount,
                          content: AppLocalizations.of(context)!
                              .confirmDeleteAccount,
                        );
                      },
                      child: Text(
                        AppLocalizations.of(context)!.deleteAccount,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize:
                                Responsive.isMobile(context) ? 14.0 : 20.0,
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
        height: (Responsive.isMobile(context)) ? 45.0 : 65.0,
        width: (Responsive.isMobile(context)) ? 45.0 : 65.0,
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
                fontSize: (Responsive.isMobile(context)) ? 25 : 40.0,
                color: Colors.grey[200],
                fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }
}
