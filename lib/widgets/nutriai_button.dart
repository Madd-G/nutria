import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:floating_draggable_widget/floating_draggable_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../blocs/blocs.dart';
import '../l10n/flutter_gen/gen_l10n/app_localizations.dart';
import '../responsive.dart';
import '../ui/chat_screen/screen/chat_screen.dart';
import '../ui/home_screen/widgets/language_bottom_sheet.dart';
import '../ui/home_screen/widgets/theme_button.dart';
import '../utils/dialogs/network_alert.dart';

class NutriAIButton extends StatelessWidget {
  const NutriAIButton({super.key, required this.mainWidget, this.screenHeight});

  final Widget mainWidget;
  final double? screenHeight;

  @override
  Widget build(BuildContext context) {
    AppLocalizations l10n = AppLocalizations.of(context)!;
    double bottomSheetHeight =
        (Platform.isIOS || Platform.isMacOS) ? 250.0 : 210.0;
    return FloatingDraggableWidget(
      mainScreenWidget: mainWidget,
      screenHeight: screenHeight,
      floatingWidget: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          return FloatingActionButton(
            foregroundColor: Colors.white,
            backgroundColor: Theme.of(context).colorScheme.primary,
            tooltip: l10n.nutriAIGreeting,
            onPressed: () {
              if (FirebaseAuth.instance.currentUser?.uid == null) {
                showModalBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                  ),
                  builder: (context) {
                    return Login(bottomSheetHeight: bottomSheetHeight);
                  },
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return BlocBuilder<NetworkBloc, NetworkState>(
                      builder: (context, state) {
                        if (state is NetworkFailure) {
                          SchedulerBinding.instance.addPostFrameCallback((_) {
                            showNetworkAlert(
                                context: context,
                                title: l10n.noInternetTitle,
                                content: l10n.cannotChat,
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                });
                          });
                          return ChatScreen(
                            l10n: l10n,
                          );
                        } else {
                          return ChatScreen(
                            l10n: l10n,
                          );
                        }
                      },
                    );
                  }),
                );
              }
            },
            child: Padding(
              padding: EdgeInsets.all(Responsive.isMobile(context)? 10.0 : 15.0),
              child: Image.asset(
                'assets/images/chatbot.png',
                color: Theme.of(context).colorScheme.onSecondaryContainer,
              ),
            ),
          );
        },
      ),
      floatingWidgetWidth: Responsive.isMobile(context)? 55.0 : 70.0,
      floatingWidgetHeight: Responsive.isMobile(context)? 55.0 : 70.0,
    );
  }
}

class Login extends StatelessWidget {
  const Login({
    super.key,
    required this.bottomSheetHeight,
  });

  final double bottomSheetHeight;

  @override
  Widget build(BuildContext context) {
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
            //             Responsive.isTablet(context) ? 25.0 : 23.0),
            //   ),
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.changeLanguage,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: Responsive.isMobile(context) ? 18.0 : 20.0,
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
            const SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.theme,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: Responsive.isMobile(context) ? 18.0 : 20.0),
                ),
                const ThemeButton(),
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppLocalizations.of(context)!.loginFirst),
                const SizedBox(
                  height: 7.0,
                ),
                GestureDetector(
                  onTap: () {
                    context.read<AuthCubit>().signInWithGoogle(context).then(
                          (value) => ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(AppLocalizations.of(context)!
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
                      padding: const EdgeInsets.fromLTRB(25.0, 8.0, 25.0, 8.0),
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
                                  ? MediaQuery.of(context).size.width * 0.15
                                  : MediaQuery.of(context).size.width * 0.25),
                          Text(
                            AppLocalizations.of(context)!.loginWithGoogle,
                            style: const TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 20.0),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: (Platform.isIOS || Platform.isMacOS) ? true : false,
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
                                (value) =>
                                    ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(AppLocalizations.of(context)!
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
                            padding:
                                const EdgeInsets.fromLTRB(25.0, 8.0, 25.0, 8.0),
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
                                        ? MediaQuery.of(context).size.width *
                                            0.15
                                        : MediaQuery.of(context).size.width *
                                            0.25),
                                Text(
                                  AppLocalizations.of(context)!.loginWithApple,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20.0),
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
  }
}
