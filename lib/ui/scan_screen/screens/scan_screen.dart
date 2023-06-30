import 'package:flutter/material.dart';
import '../widgets/widgets.dart';

class ScanScreen extends StatelessWidget {
  const ScanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Flexible(flex: 1, child: CameraScreenHeader()),
          Expanded(flex: 9, child: CameraContent()),
        ],
      ),
    );
  }
}
