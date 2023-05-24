import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../screens.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({Key? key}) : super(key: key);

  @override
  ScanScreenState createState() => ScanScreenState();
}

class ScanScreenState extends State<ScanScreen> {
  final ImagePicker _picker = ImagePicker();
  File? imageFile;

  CameraController? cameraController;
  late List cameras;
  late int selectedCameraIndex;
  late String imgPath;
  File? imageGallery;

  Future initCamera(CameraDescription cameraDescription) async {
    if (cameraController != null) {
      await cameraController?.dispose();
    }

    cameraController =
        CameraController(cameraDescription, ResolutionPreset.high);

    cameraController?.addListener(
      () {
        if (mounted) {
          setState(
            () {},
          );
        }
      },
    );

    if (cameraController!.value.hasError) {
      if (kDebugMode) {
        print('Camera Error ${cameraController?.value.errorDescription}');
      }
    }

    try {
      await cameraController?.initialize();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    if (mounted) {
      setState(
        () {},
      );
    }
  }

  Widget cameraPreview() {
    if (cameraController == null || !cameraController!.value.isInitialized) {
      return const Text(
        'Loading',
        style: TextStyle(
            color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: CameraPreview(cameraController!),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    availableCameras().then(
      (value) {
        cameras = value;
        if (cameras.isNotEmpty) {
          setState(
            () {
              selectedCameraIndex = 0;
            },
          );
          initCamera(cameras[selectedCameraIndex]).then(
            (value) {},
          );
        } else {
          if (kDebugMode) {
            print('No camera available');
          }
        }
      },
    ).catchError(
      (e) {
        if (kDebugMode) {
          print('Error : ${e.code}');
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: cameraPreview(),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 120,
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.only(bottom: 20),
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () async {
                              XFile? pickedFile = await _picker.pickImage(
                                  source: ImageSource.gallery);
                              if (pickedFile != null) {
                                setState(() {
                                  imageFile = File(pickedFile.path);
                                });
                                if (mounted) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          PreviewScreen(imgPath: pickedFile),
                                    ),
                                  );
                                }
                              }
                            },
                            child: const SizedBox(
                              width: 55,
                              height: 55,
                              child: CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/images/gallery.png'),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          FloatingActionButton(
                            backgroundColor: Colors.white,
                            onPressed: () async {
                              try {
                                await cameraController?.takePicture().then(
                                  (value) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            PreviewScreen(imgPath: value),
                                      ),
                                    );
                                  },
                                );
                              } catch (e) {
                                if (kDebugMode) {
                                  print(e);
                                }
                              }
                            },
                            child: ClipOval(
                              child: Container(
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const Expanded(
                    child:
                        Align(alignment: Alignment.center, child: SizedBox()),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
