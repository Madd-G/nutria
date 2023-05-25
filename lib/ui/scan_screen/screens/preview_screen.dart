import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class PreviewScreen extends StatefulWidget {
  final XFile imgPath;

  const PreviewScreen({Key? key, required this.imgPath}) : super(key: key);

  @override
  PreviewScreenState createState() => PreviewScreenState();
}

class PreviewScreenState extends State<PreviewScreen> {
  CameraController? cameraController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: Image.file(
              File(widget.imgPath.path),
              fit: BoxFit.fitWidth,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
            child: Align(
              alignment: Alignment.bottomCenter,
              child:
                  ElevatedButton(onPressed: () {}, child: const Text('SCAN')),
            ),
          )
        ],
      ),
    );
  }
}
