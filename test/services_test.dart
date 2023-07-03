import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mockito/mockito.dart';
import 'package:nutria/models/prediction_model.dart';

class MockClient extends Mock with Dio {}

void main() async {
  late Dio dio = Dio();
  late DioAdapter dioAdapter;
  Response<dynamic> response;

  group(
    'Prediksi',
    () {
      const baseUrl = 'https://nutria-pemw7i5uxa-et.a.run.app/nutria';

      const datas =
          Prediction(classLabel: '1', className: 'Apel', confidence: '89.79');

      setUp(() {
        dio = Dio(BaseOptions(baseUrl: baseUrl));
        dioAdapter = DioAdapter(dio: dio);
      });

      test(
        'predict image',
        () async {
          const route = '/detect';
          dioAdapter.onPost(route, (server) => server.reply(201, null),
              data: datas);
          response = await dio.post(route, data: datas);

          expect(response.statusCode, 201);

          dioAdapter.onPost(
              route,
              (server) => server.throws(401,
                  DioException(requestOptions: RequestOptions(path: route))));
        },
      );
    },
  );
}
