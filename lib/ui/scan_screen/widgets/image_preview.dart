import 'package:flutter/material.dart';
import 'dart:io';

class ImagePreview extends StatelessWidget {
  const ImagePreview({
    super.key,
    required this.imagePath,
  });

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.file(
        File(imagePath),
        width: double.infinity,
        fit: BoxFit.fitWidth,
      ),
    );
  }
}
