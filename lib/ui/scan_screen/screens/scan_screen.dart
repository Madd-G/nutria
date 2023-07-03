import 'package:flutter/material.dart';
import '../../../responsive.dart';
import '../widgets/widgets.dart';

class ScanScreen extends StatelessWidget {
  const ScanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          const Flexible(flex: 1, child: CameraScreenHeader()),
          // const Flexible(flex: 1, child: SizedBox()),
          Expanded(flex: Responsive.isTablet(context)? 20 :  9, child: const CameraContent()),
          // Expanded(child: const CameraContent()),
        ],
      ),
    );
  }
}
