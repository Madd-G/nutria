import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_ios/image_picker_ios.dart';
import '../../ios/.symlinks/plugins/image_picker_ios/test/test_api.g.dart';
import '../../ios/.symlinks/plugins/image_picker_ios/test/image_picker_ios_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final ImagePickerIOS picker = ImagePickerIOS();
  late ApiLogger log;

  setUp(
    () {
      log = ApiLogger();
      MockHostImagePickerApi.setup(log);
    },
  );

  test(
    'Ambil gambar dari kamera',
    () async {
      PickedFile? imageFromCamera =
          await picker.pickImage(source: ImageSource.camera);

      expect(imageFromCamera, isNotNull);
    },
  );
  test(
    'Ambil gambar dari galeri',
    () async {
      PickedFile? imageFromGallery =
          await picker.pickImage(source: ImageSource.gallery);

      expect(imageFromGallery, isNotNull);
    },
  );
}
