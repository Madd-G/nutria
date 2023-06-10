import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import '../widgets/widgets.dart';
import 'dart:io';

class PreviewScreen extends StatelessWidget {
  final File? imgPath;

  PreviewScreen({Key? key, this.imgPath}) : super(key: key);

  final ImageCropper imageCropper = ImageCropper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          ImagePreview(imagePath: imgPath!.path),
          IdentifyButton(
            imagePath: imgPath!.path,
          ),
        ],
      ),
    );
  }
}

