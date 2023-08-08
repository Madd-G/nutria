import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:nutria/models/prediction_model.dart';

Future<void> main() async {
  late List<Prediction> detectedObject;

  var base64Image = 'assets/images/kangkung.png';

  FormData requestBody =
  FormData.fromMap({"file": await MultipartFile.fromFile(base64Image)});

  var dio = Dio();

  var baseUrl = "https://nutriav3-it6ihfa5za-uc.a.run.app/nutria";
  var response = await dio.post(
    '$baseUrl/detect',
    data: requestBody,
    options: Options(headers: {'Content-Type': 'application/json'}),
  );

  if (response.statusCode == 200) {
    var data = response.data;
    List<Prediction> predictions = (data as List<dynamic>)
        .map((item) => Prediction.fromJson(item))
        .toList();

    detectedObject = predictions;
  } else {
    fail(
      'Request failed with status code ${response.statusCode}',
    );
  }
  setUp(() async {
    detectedObject = detectedObject;
  });

  test(
    'Kembalian dalam bentuk List',
    () {
      expect(detectedObject, isList);
    },
  );
  test(
    'Objek terdeteksi berjumlah 1',
    () {
      expect(detectedObject.length, 1);
    },
  );
  test(
    'Class label adalah 8 dan bertipe string',
    () {
      expect(detectedObject[0].classLabel, '8');
      expect(detectedObject[0].classLabel.runtimeType, String);
    },
  );
  test(
    'Class name adalah Kangkung dan bertipe string',
    () {
      expect(detectedObject[0].className, 'Kangkung');
      expect(detectedObject[0].className.runtimeType, String);
    },
  );
  test(
    'Nilai confidence adalah 92.22273254394531 dan bertipe string',
    () {
      expect(detectedObject[0].confidence, '92.22273254394531');
      expect(detectedObject[0].confidence.runtimeType, String);
    },
  );
}
