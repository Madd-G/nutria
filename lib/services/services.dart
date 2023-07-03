import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:nutria/models/models.dart';

class ApiService {
  final Dio dio = Dio();

  ApiService() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          if (e.response!.statusCode == 401) {
          } else {}
          return handler.next(e);
        },
      ),
    );
  }

  static Future<List<Prediction>> uploadImage(String imgPath) async {
    final Dio dio = Dio();

    const String baseUrl =
        // 'https://alamsyahyolo-35iuseuykq-et.a.run.app/nutria/';
        // 'https://nutria-pemw7i5uxa-et.a.run.app/nutria/'; //v2
        // 'http://192.168.18.55:8000/nutria/';
        // 'http://10.0.2.2:8000/nutria/';
        // 'http://127.0.0.1:8000/nutria/';
        'http://localhost:8000/nutria/';
    FormData formData =
        FormData.fromMap({"file": await MultipartFile.fromFile(imgPath)});
    Response response = await dio.post('${baseUrl}detect', data: formData);
    if (response.statusCode != 200) {
      print('<<<<<<<<<<<<Error>>>>>>>>>>>>');
      throw Exception("Error");
    }
    String responses = jsonEncode(response.data).toString();
    print('<<<<<<<<<<<< $responses');
    List<Prediction> result = modelFromJson(responses);
    result = result
        .where((element) => double.parse(element.confidence) > 10)
        .toList();
    print('<<<<<<<<<<<< $result');
    return result;
  }
}
