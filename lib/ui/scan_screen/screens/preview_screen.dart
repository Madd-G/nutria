import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import '../widgets/widgets.dart';

class PreviewScreen extends StatelessWidget {
  final XFile imgPath;

  const PreviewScreen({Key? key, required this.imgPath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          ImagePreview(imagePath: imgPath.path),
          IdentifyButton(imagePath: imgPath.path)
        ],
      ),
    );
  }
}
