import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../blocs/blocs.dart';
import '../ui/chat_screen/screen/chat_screen.dart';

class LoginDialog extends StatelessWidget {
  const LoginDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (dialogContext) {
            return AlertDialog(
              insetPadding: const EdgeInsets.all(8.0),
              title: Text('Login'.tr),
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
                              (value) =>
                                  ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Login Successfully'.tr),
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
                          padding:
                              const EdgeInsets.fromLTRB(25.0, 8.0, 25.0, 8.0),
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
                                style: TextStyle(fontWeight: FontWeight.w700),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        context.read<AuthCubit>().signInWithApple(context).then(
                              (value) =>
                                  ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Login Successfully'.tr),
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
                          padding:
                              const EdgeInsets.fromLTRB(25.0, 8.0, 25.0, 8.0),
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
                                style: TextStyle(fontWeight: FontWeight.w700),
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
      },
      child: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: Theme.of(context).colorScheme.primary,
        tooltip: 'Hello, I\'m NutriAI Bot'.tr,
        onPressed: () {
          if (FirebaseAuth.instance.currentUser?.uid == null) {
            context.read<AuthCubit>().signInWithGoogle(context).then(
                (value) async => await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ChatScreen())));
          } else {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ChatScreen()));
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/images/AI.png',
          ),
        ),
      ),
    );
  }
}
