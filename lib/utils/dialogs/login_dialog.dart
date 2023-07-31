import 'dart:io';
import 'package:flutter/material.dart';
import 'package:nutria/l10n/flutter_gen/gen_l10n/app_localizations.dart';
import '../../../blocs/blocs.dart';
import '../../../responsive.dart';
import '../../ui/home_screen/widgets/widgets.dart';

class LoginDialog extends StatelessWidget {
  const LoginDialog({super.key});

  @override
  Widget build(BuildContext context) {
    double bottomSheetHeight =
        (Platform.isIOS || Platform.isMacOS) ? 300.0 : 260.0;
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          // barrierColor: Colors.transparent,
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
                    // Center(
                    //   child: Text(
                    //     'Settings',
                    //     style: TextStyle(
                    //         fontSize:
                    //             Responsive.isMobile(context) ? 23.0 : 25.0),
                    //   ),
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.changeLanguage,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize:
                                Responsive.isMobile(context) ? 14.0 : 20.0,
                          ),
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
                              builder: (dialogContext) {
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
                    const SizedBox(
                      height: 20.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.loginFirst,
                          style: TextStyle(
                              fontSize:
                                  Responsive.isMobile(context) ? 14.0 : 20.0),
                        ),
                        const SizedBox(
                          height: 7.0,
                        ),
                        GestureDetector(
                          onTap: () {
                            context
                                .read<AuthCubit>()
                                .signInWithGoogle(context)
                                .then(
                                  (value) => ScaffoldMessenger.of(context)
                                      .showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          AppLocalizations.of(context)!
                                              .loginSuccessfully),
                                    ),
                                  ),
                                );
                            // (mounted) {
                            Navigator.pop(context);
                            // };
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  25.0, 8.0, 25.0, 8.0),
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/google.png',
                                    width: 27.0,
                                    height: 27.0,
                                  ),
                                  SizedBox(
                                      width: Responsive.isMobile(context)
                                          ? MediaQuery.of(context).size.width *
                                              0.15
                                          : MediaQuery.of(context).size.width *
                                              0.25),
                                  Text(
                                    AppLocalizations.of(context)!
                                        .loginWithGoogle,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: Responsive.isMobile(context)
                                            ? 14
                                            : 20.0),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        Visibility(
                          visible: (Platform.isIOS || Platform.isMacOS)
                              ? true
                              : false,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 5.0,
                              ),
                              GestureDetector(
                                onTap: () {
                                  context
                                      .read<AuthCubit>()
                                      .signInWithApple(context)
                                      .then(
                                        (value) => ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                AppLocalizations.of(context)!
                                                    .loginSuccessfully),
                                          ),
                                        ),
                                      );
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    border: Border.all(color: Colors.grey),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        25.0, 8.0, 25.0, 8.0),
                                    child: Row(
                                      // mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/images/apple-logo.png',
                                          width: 25.0,
                                          height: 25.0,
                                        ),
                                        SizedBox(
                                            width: Responsive.isMobile(context)
                                                ? MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.15
                                                : MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.25),
                                        Text(
                                          AppLocalizations.of(context)!
                                              .loginWithApple,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize:
                                                  Responsive.isMobile(context)
                                                      ? 14.0
                                                      : 20.0),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
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
        child: Icon(
          Icons.account_circle,
          size: (Responsive.isMobile(context)) ? 45 : 65.0,
          color: Colors.white,
        ),
      ),
    );
  }
}
