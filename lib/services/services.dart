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
  // final String _baseUrl = 'http://192.168.18.55:8000/nutria/';
  final String _baseUrl = 'http://10.0.2.2:8000/nutria/';
  // final String _baseUrl = 'http://127.0.0.1:8000/nutria/';

  Future<DataModel> fetchRecommendations() async {
    try {
      final response = await _dio.get('${_baseUrl}get-all');
      return DataModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<DataModel> fetchFruits() async {
    try {
      final response = await _dio.get('${_baseUrl}get-fruit');
      return DataModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<DataModel> fetchVegetables() async {
    try {
      final response = await _dio.get('${_baseUrl}get-vegetable');
      return DataModel.fromJson(response.data);
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
