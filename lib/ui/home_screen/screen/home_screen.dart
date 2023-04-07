import 'package:flutter/material.dart';
import 'package:nutria/utils/constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, profileRoute);
          },
          child: const Text('Home Screen'),
        ),
      ),
    );
  }
}
