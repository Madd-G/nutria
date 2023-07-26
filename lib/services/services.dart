import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:nutria/models/models.dart';

class ApiService {
  ApiService() {
    _dio.interceptors.add(
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

  final Dio _dio = Dio();

  // final String _baseUrl = 'https://nutria-pemw7i5uxa-et.a.run.app/nutria/';
  // final String _baseUrl = 'https://nutria-it6ihfa5za-et.a.run.app/nutria/';
  String? baseUrl = dotenv.env['NUTRIA_BASE_URL'];

  Future<List<Prediction>> uploadImage(String imgPath) async {
    FormData formData =
        FormData.fromMap({"file": await MultipartFile.fromFile(imgPath)});
    Response response = await _dio.post('${baseUrl}/detect', data: formData);
    String responses = jsonEncode(response.data).toString();
    List<Prediction> result = modelFromJson(responses);
    result = result
        .where((element) => double.parse(element.confidence) > 80)
        .toList();
    return result;
  }
}
