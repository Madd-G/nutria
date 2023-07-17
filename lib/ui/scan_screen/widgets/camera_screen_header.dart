import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CameraScreenHeader extends StatelessWidget {
  const CameraScreenHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:  Center(
        child: Text(
          "Scan fruits or vegetables".tr,
          style: const TextStyle(
            fontFamily: 'GT Maru',
            color: Colors.white,
            fontSize: 21,
          ),
        ),
      ),
    );
  }
}
