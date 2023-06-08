import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:nutria/models/models.dart';
import 'package:either_option/either_option.dart';
import 'package:http/http.dart' as http;

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
      Response response = await _dio.get('${_baseUrl}get-all');
      return DataModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<DataModel> fetchFruits() async {
    try {
      Response response = await _dio.get('${_baseUrl}get-fruit');
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

  Future<Either<String, List<Data>>> searchForWord(String input) async {
    try {
      final searchWordRequest = await http.Client().get(
        Uri.parse('${_baseUrl}get-all/$input'),
      );
      final wordResponse = dataModelFromJson(searchWordRequest.body);

      if (searchWordRequest.statusCode == 200 && wordResponse.isNotEmpty) {
        return Right(wordResponse);
      }
      return Left(
          "Sorry pal, we couldn't find definitions for the word you were looking for.");
    } catch (e) {
      return Left(e.toString());
    }
  }
}
