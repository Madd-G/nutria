import 'dart:convert';
import 'package:dio/dio.dart';
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
        onError: (DioError e, handler) {
          if (e.response!.statusCode == 401) {
          } else {}
          return handler.next(e);
        },
      ),
    );
  }

  final Dio _dio = Dio();
  final String _baseUrl = 'http://192.168.18.55:8000/nutria/';

  Future<RecommendationsModel> fetchRecommendations() async {
    try {
      final response = await _dio.get('${_baseUrl}get-all');
      return RecommendationsModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<PredictionModel>> uploadImage(String imgPath) async {
    FormData formData =
        FormData.fromMap({"file": await MultipartFile.fromFile(imgPath)});
    Response response = await _dio.post('${_baseUrl}detect', data: formData);
    String responses = jsonEncode(response.data).toString();
    List<PredictionModel> result = modelFromJson(responses);
    return result;
  }
}
