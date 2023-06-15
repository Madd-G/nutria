import 'package:flutter/material.dart';
import '../widgets/widgets.dart';

class ScanScreen extends StatelessWidget {
  const ScanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: const [
          Flexible(
            flex: 1,
            child: SafeArea(
              child: Center(
                child: Text(
                  "Scan your thing",
                  style: TextStyle(
                    fontFamily: 'GT Maru',
                    color: Colors.white,
                    fontSize: 21,
                  ),
                ),
              ),
            ),
          ),
          Expanded(flex: 9, child: CameraContent()),
        ],
      ),
    );
  }
}
