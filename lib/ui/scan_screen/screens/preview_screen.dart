import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PreviewScreen extends StatefulWidget {
  final XFile imgPath;

  const PreviewScreen({Key? key, required this.imgPath}) : super(key: key);

  @override
  PreviewScreenState createState() => PreviewScreenState();
}

class PreviewScreenState extends State<PreviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: 800.0,
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
