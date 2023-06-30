import 'package:flutter/material.dart';

class CameraScreenHeader extends StatelessWidget {
  const CameraScreenHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child:  Center(
        child: Text(
          "Scan your thing",
          style: TextStyle(
            fontFamily: 'GT Maru',
            color: Colors.white,
            fontSize: 21,
          ),
        ),
      ),
    );
  }
}
