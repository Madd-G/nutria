import 'package:flutter/material.dart';

class LoginButtonApple extends StatelessWidget {
  const LoginButtonApple(
      {super.key, required this.text, required this.onPressed});

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(color: Colors.black),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
            child: Row(
              children: [
                Image.asset(
                  'assets/images/apple-logo.png',
                  width: 17.0,
                  height: 17.0,
                ),
                const SizedBox(
                  width: 3.0,
                ),
                Text(
                  text,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
