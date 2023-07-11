import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../responsive.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              insetPadding: const EdgeInsets.all(8.0),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    width: 10.0,
                  ),
                  const Text(
                    'Account',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.close),
                  ),
                ],
              ),
              content: SizedBox(
                width: Responsive.isTablet(context) ? 530 : 350.0,
                height: Responsive.isTablet(context) ? 150.0 : 150.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: (Responsive.isTablet(context)) ? 50.0 : 32.0,
                          width: (Responsive.isTablet(context)) ? 50.0 : 32.0,
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
                                  fontSize: (Responsive.isTablet(context))
                                      ? 35
                                      : 17.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          FirebaseAuth.instance.currentUser!.email!,
                          style: const TextStyle(fontSize: 20.0),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 25.0,
                    ),
                    GestureDetector(
                      onTap: () async {
                        await googleSignIn.signOut();
                        await FirebaseAuth.instance.signOut().then(
                              (value) =>
                                  ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Berhasil logout'),
                                ),
                              ),
                            );
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Log Out',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 20.0),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    GestureDetector(
                      onTap: () async {
                        await FirebaseAuth.instance.currentUser!.delete().then(
                              (value) =>
                                  ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Account deleted'),
                                ),
                              ),
                            );
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Delete Account',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20.0,
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
                fontSize: (Responsive.isTablet(context)) ? 35 : 30.0,
                color: Colors.white,
                fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }
}
