import 'dart:io';
import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nutria/l10n/flutter_gen/gen_l10n/app_localizations.dart';
import '../../screens.dart';

class CameraContent extends StatefulWidget {
  const CameraContent({Key? key, required this.l10n}) : super(key: key);

  final AppLocalizations l10n;

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
  String nutriaUrl = '';

  @override
  void initState() {
    super.initState();
    fetchFirestoreValue();
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
            print(widget.l10n.noCameraAvailable);
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

  Future<String> fetchFirestoreValue() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('url')
          .doc('HcMAeajSAeVo7S6cytmt')
          .get();

      if (snapshot.exists) {
        setState(() {
          Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
          nutriaUrl = data['nutria-url'];
        });
      } else {
        setState(() {
          nutriaUrl = 'Value not found';
        });
      }
      return nutriaUrl;
    } catch (e) {
      setState(() {
        // Error occurred while fetching data.
        nutriaUrl = 'Error: $e';
      });
      rethrow;
    }
  }

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

  pickImageFromGallery() async {
    try {
      XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile == null) return;

      File? img = File(pickedFile.path);
      img = await cropImage(imageFile: File(pickedFile.path));
      setState(() {
        imageFile = img;
      });
      if (mounted) {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => PreviewScreen(imgPath: imageFile!),
        //   ),
        // );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailObjectScreen(
              image: imageFile!,
              url: nutriaUrl,
            ),
          ),
        );
      }
    } on PlatformException {
      // context.read<ScreenBloc>().add(ScreenEventGoToScanScreen());
      (mounted) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ScanScreen()));
      };
    }
  }

  takePictureFromCamera() async {
    cameraController!.setFlashMode(FlashMode.off);
    try {
      await cameraController?.takePicture().then(
        (value) async {
          File? img = File(value.path);
          img = await cropImage(imageFile: File(value.path));
          if (mounted) {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => PreviewScreen(imgPath: img!),
            //   ),
            // );
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailObjectScreen(
                  image: img!,
                  url: nutriaUrl,
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<File?> cropImage({required File imageFile}) async {
    CroppedFile? croppedImage = await ImageCropper().cropImage(
        sourcePath: imageFile.path,
        aspectRatioPresets: (Platform.isAndroid || Platform.isIOS)
            ? [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9
              ]
            : [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio5x3,
                CropAspectRatioPreset.ratio5x4,
                CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.ratio16x9
              ],
        uiSettings: [
          AndroidUiSettings(
            toolbarColor: Theme.of(context).colorScheme.primary,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
          ),
          IOSUiSettings()
        ]);

    if (croppedImage == null) {
      (mounted) {
        // context.read<ScreenBloc>().add(ScreenEventGoToScanScreen());
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ScanScreen()));
      };
    }

    return File(croppedImage!.path);
  }

  @override
  void dispose() {
    cameraController?.dispose();
    super.dispose();
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
                        await pickImageFromGallery();
                        (mounted) {
                          // context.read<ScreenBloc>().add(ScreenEventGoToPreviewScreen());
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => PreviewScreen()));
                        };
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
                    onPressed: () async => await takePictureFromCamera(),
                  ),
                ),
                Expanded(
                  child: Align(alignment: Alignment.center, child: Container()),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
