import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../screens.dart';

class CameraContent extends StatefulWidget {
  const CameraContent({Key? key}) : super(key: key);

  @override
  State<CameraContent> createState() => _CameraContentState();
}

class _CameraContentState extends State<CameraContent> {
  File? imageFile;
  final ImagePicker _picker = ImagePicker();
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
    return AspectRatio(
      aspectRatio: 1 / cameraController!.value.aspectRatio,
      child: CameraPreview(
        cameraController!,
      ),
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
    return Stack(
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
                    child: GestureDetector(
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
                      child: const CircleAvatar(
                        radius: 25,
                        backgroundImage:
                            AssetImage('assets/images/gallery.png'),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 100.0,
                  height: 100.0,
                  child: IconButton(
                    icon: Image.asset(
                      "assets/images/take_photo_button.png",
                    ),
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
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {},
                      child: Icon(
                        Icons.change_circle_rounded,
                        size: 55,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
