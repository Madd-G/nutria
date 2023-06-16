import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nutria/blocs/blocs.dart';
import 'package:nutria/ui/chat_screen/screen/chat_screen.dart';

class WelcomeSection extends StatelessWidget {
  const WelcomeSection({super.key, required this.size});

  final Size size;

  @override
  Widget build(BuildContext context) {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    return Container(
      color: Theme.of(context).colorScheme.primary,
      height: 220,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: size.height * 0.055,
            ),
            const Text(
              'Hello alamsyah',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: size.height * 0.005,
            ),
            GestureDetector(
              onTap: () async {
                await googleSignIn.signOut();
                await FirebaseAuth.instance.signOut();
              },
              child: const Text(
                'Let\'s Learn More About\nFruits and Vegetables',
                style: TextStyle(
                  letterSpacing: 2.5,
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
