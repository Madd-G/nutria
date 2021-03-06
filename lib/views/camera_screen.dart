import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nutria/views/preview_screen.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
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
      showCameraException(e);
    }

    if (mounted) {
      setState(
        () {},
      );
    }
  }

  /// Display camera preview
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
    // return AspectRatio(
    //   aspectRatio: cameraController!.value.aspectRatio,
    //   child: CameraPreview(cameraController!),
    // );
  }

  Widget galleryButton(context) {
    return Expanded(
      child: Align(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            GestureDetector(
              onTap: () => pickImageGallery(context),
              child: Container(
                width: 55,
                height: 55,
                child: Image.asset(
                  'assets/images/apel.png',
                  fit: BoxFit.cover,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget cameraControl(context) {
    return Expanded(
      child: Align(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            FloatingActionButton(
              child: ClipOval(
                child: Container(
                  color: Colors.white,
                ),
              ),
              backgroundColor: Colors.white,
              onPressed: () {
                onCapture(context);
              },
            )
          ],
        ),
      ),
    );
  }

  Widget cameraToggle() {
    if (cameras == null || cameras.isEmpty) {
      return const Spacer();
    }

    CameraDescription selectedCamera = cameras[selectedCameraIndex];
    CameraLensDirection lensDirection = selectedCamera.lensDirection;

    return Expanded(
      child: Align(
        alignment: Alignment.centerLeft,
        child: TextButton.icon(
          onPressed: () {
            onSwitchCamera();
          },
          icon: Icon(
            getCameraLensIcons(lensDirection),
            color: Colors.white,
            size: 24,
          ),
          label: Text(
            lensDirection
                .toString()
                .substring(lensDirection.toString().indexOf('.') + 1)
                .toUpperCase(),
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }

  Future pickImageGallery(context) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image != null) {
        return Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PreviewScreen(imgPath: image),
          ),
        );
      }
      if (image == null) return;

      final imageTemporary = File(image.path);
      imageGallery = imageTemporary;
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(
          'Failed to pick image,\n$e',
        );
      }
    }
  }

  onCapture(context) async {
    try {
      await cameraController?.takePicture().then(
        (value) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PreviewScreen(imgPath: value),
            ),
          );
        },
      );
    } catch (e) {
      showCameraException(e);
    }
  }

  @override
  void initState() {
    super.initState();
    availableCameras().then(
      (value) {
        cameras = value;
        if (cameras.length > 0) {
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  galleryButton(context),
                  cameraControl(context),
                  cameraToggle(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }



  getCameraLensIcons(lensDirection) {
    switch (lensDirection) {
      case CameraLensDirection.back:
        return CupertinoIcons.switch_camera;
      case CameraLensDirection.front:
        return CupertinoIcons.switch_camera_solid;
      case CameraLensDirection.external:
        return CupertinoIcons.photo_camera;
      default:
        return Icons.device_unknown;
    }
  }

  onSwitchCamera() {
    selectedCameraIndex =
        selectedCameraIndex < cameras.length - 1 ? selectedCameraIndex + 1 : 0;
    CameraDescription selectedCamera = cameras[selectedCameraIndex];
    initCamera(selectedCamera);
  }

  showCameraException(e) {
    String errorText = 'Error ${e.code} \nError message: ${e.description}';
    if (kDebugMode) {
      print(errorText);
    }
  }
}
