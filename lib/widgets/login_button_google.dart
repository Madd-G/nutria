import 'package:flutter/material.dart';

class LoginButtonGoogle extends StatelessWidget {
  const LoginButtonGoogle(
      {super.key, required this.text, required this.onPressed});

  final String text;

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
                  'assets/images/google.png',
                  width: 19.0,
                  height: 19.0,
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
