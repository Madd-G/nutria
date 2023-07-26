import 'package:camera_avfoundation/src/avfoundation_camera.dart';
import 'package:camera_platform_interface/camera_platform_interface.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../ios/.symlinks/plugins/camera_avfoundation/test/method_channel_mock.dart';

const String _channelName = 'plugins.flutter.io/camera_avfoundation';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AVFoundationCamera camera;
  late int cameraId;

  setUp(
    () async {
      MethodChannelMock(
        channelName: _channelName,
        methods: <String, dynamic>{
          'create': <String, dynamic>{'cameraId': 1},
          'initialize': null
        },
      );
      camera = AVFoundationCamera();
      cameraId = await camera.createCamera(
        const CameraDescription(
          name: 'Camera 1',
          lensDirection: CameraLensDirection.back,
          sensorOrientation: 0,
        ),
        ResolutionPreset.high,
      );
      final Future<void> initializeFuture = camera.initializeCamera(cameraId);
      camera.cameraEventStreamController.add(
        CameraInitializedEvent(
          cameraId,
          1920,
          1080,
          ExposureMode.auto,
          true,
          FocusMode.auto,
          true,
        ),
      );
      await initializeFuture;
    },
  );

  test(
    'Melakukan pengecekan apakah kamera tersedia',
    () async {
      final List<dynamic> availableCameras = <dynamic>[
        <String, dynamic>{
          'name': 'Camera 1',
          'lensFacing': 'back',
          'sensorOrientation': 1
        },
      ];
      MethodChannelMock(
        channelName: _channelName,
        methods: <String, dynamic>{'availableCameras': availableCameras},
      );

      final List<CameraDescription> cameras = await camera.availableCameras();

      expect(cameras, isNotNull);
    },
  );

  test(
    'Mengembalikan camera exception ketika terjadi error',
    () {
      MethodChannelMock(
        channelName: _channelName,
        methods: <String, dynamic>{
          'availableCameras': PlatformException(
            code: 'TESTING_ERROR_CODE',
            message: 'Mock error message used during testing.',
          )
        },
      );

      expect(
        camera.availableCameras,
        throwsA(
          isA<CameraException>()
              .having(
                  (CameraException e) => e.code, 'code', 'TESTING_ERROR_CODE')
              .having((CameraException e) => e.description, 'description',
                  'Mock error message used during testing.'),
        ),
      );
    },
  );

  test(
    'Mengambil gambar dan mengembalikan XFile',
    () async {
      MethodChannelMock(
          channelName: _channelName,
          methods: <String, dynamic>{'takePicture': '/test/path.jpg'});

      final XFile file = await camera.takePicture(cameraId);

      expect(file, isNotNull);
      expect(file.name, 'path.jpg');
      expect(file.path, '/test/path.jpg');
    },
  );
}
