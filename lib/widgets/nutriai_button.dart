import 'package:firebase_auth/firebase_auth.dart';
import 'package:floating_draggable_widget/floating_draggable_widget.dart';
import 'package:flutter/material.dart';

import '../blocs/blocs.dart';
import '../ui/chat_screen/screen/chat_screen.dart';
import '../ui/home_screen/widgets/login_dialog.dart';
import '../ui/home_screen/widgets/logout_dialog.dart';

class NutriAIButton extends StatelessWidget {
  const NutriAIButton({super.key, required this.mainWidget, this.screenHeight});

  final Widget mainWidget;
  final double? screenHeight;

  @override
  Widget build(BuildContext context) {
    return FloatingDraggableWidget(
      mainScreenWidget: mainWidget,
      screenHeight: screenHeight,
      floatingWidget: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            return FloatingActionButton(
              foregroundColor: Colors.white,
              backgroundColor: Theme.of(context).colorScheme.primary,
              tooltip: 'Hello, may I help you?',
              onPressed: () {
                if (FirebaseAuth.instance.currentUser?.uid == null) {
                  showDialog(
                    context: context,
                    builder: (dialogContext) {
                      return AlertDialog(
                        insetPadding: const EdgeInsets.all(8.0),
                        title: const Text('Login'),
                        content: SizedBox(
                          width: 300.0,
                          height: 80.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  context
                                      .read<AuthCubit>()
                                      .signInWithGoogle(context)
                                      .then(
                                        (value) => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const ChatScreen(),
                                          ),
                                        ),
                                      );
                                  // (mounted) {
                                  Navigator.pop(dialogContext);

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
                                      children: [
                                        Image.asset(
                                          'assets/images/google.png',
                                          width: 30.0,
                                          height: 30.0,
                                        ),
                                        const SizedBox(width: 10.0),
                                        const Text(
                                          'Google',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  context
                                      .read<AuthCubit>()
                                      .signInWithApple(context)
                                      .then(
                                        (value) => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const ChatScreen(),
                                          ),
                                        ),
                                      );
                                  Navigator.pop(dialogContext);
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
                                      children: [
                                        Image.asset(
                                          'assets/images/apple-logo.png',
                                          width: 30.0,
                                          height: 30.0,
                                        ),
                                        const SizedBox(width: 10.0),
                                        const Text(
                                          'Apple',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ChatScreen()));
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'assets/images/AI.png',
                ),
              ),
            );
          }),
      floatingWidgetWidth: 55,
      floatingWidgetHeight: 55,
    );
  }
}

// FloatingActionButton(
// foregroundColor: Colors.white,
// backgroundColor: Theme.of(context).colorScheme.primary,
// tooltip: 'Hello, may I help you?',
// onPressed: () {
// if (FirebaseAuth.instance.currentUser?.uid == null) {
// context.read<AuthCubit>().signInWithGoogle(context).then(
// (value) async => await Navigator.push(
// context,
// MaterialPageRoute(
// builder: (context) => const ChatScreen())));
// } else {
// Navigator.push(context,
// MaterialPageRoute(builder: (context) => const ChatScreen()));
// }
// },
// child: Padding(
// padding: const EdgeInsets.all(8.0),
// child: Image.asset(
// 'assets/images/AI.png',
// ),
// ),
// ),
