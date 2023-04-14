import 'package:dio/dio.dart';
import 'package:nutria/models/recommendations_model.dart';

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

  final String _baseUrl = 'http://127.0.0.1:8000/nutria/';

  Future<RecommendationsModel> fetchRecommendations() async {
    try {
      final response = await _dio.get('${_baseUrl}get-all');

      return RecommendationsModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
