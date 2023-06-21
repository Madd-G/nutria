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
        onError: (DioException e, handler) {
          if (e.response!.statusCode == 401) {
          } else {}
          return handler.next(e);
        },
      ),
    );
  }

  final Dio _dio = Dio();

  final String _baseUrl =
      'https://alamsyahyolo-35iuseuykq-et.a.run.app/nutria/';

  Future<DataModel> fetchRecommendations() async {
    try {
      Response response = await _dio.get('${_baseUrl}get-all');
      return DataModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<ArticleModel> fetchArticles() async {
    try {
      Response response = await _dio.get('${_baseUrl}get-articles');
      return ArticleModel.fromJson(response.data);
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

  Future<List<Prediction>> uploadImage(String imgPath) async {
    FormData formData =
        FormData.fromMap({"file": await MultipartFile.fromFile(imgPath)});
    Response response = await _dio.post('${_baseUrl}detect', data: formData);
    String responses = jsonEncode(response.data).toString();
    List<Prediction> result = modelFromJson(responses);
    result = result
        .where((element) => double.parse(element.confidence) > 50)
        .toList();
    return result;
  }

  Future<Either<String, List<Data>>> searchForItem(String input) async {
    try {
      final searchItemRequest = await http.Client().get(
        Uri.parse('${_baseUrl}get-all/$input'),
      );
      final itemResponse = dataModelFromJson(searchItemRequest.body);

      if (searchItemRequest.statusCode == 200 && itemResponse.isNotEmpty) {
        return Right(itemResponse);
      }
      return Left("No fruit or vegetables detected");
    } catch (e) {
      return Left(e.toString());
    }
  }
}
