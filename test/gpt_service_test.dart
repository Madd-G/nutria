import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mockito/mockito.dart';

class MockClient extends Mock with Dio {}

void main() async {
  late Dio dio = Dio();
  late DioAdapter dioAdapter;
  Response<dynamic> response;

  group(
    'chatgpt test',
    () {
      const baseUrl = 'https://api.openai.com/v1/chat/completions';

      const datas = 'Hallo';

      setUp(() {
        dio = Dio(BaseOptions(baseUrl: baseUrl));
        dioAdapter = DioAdapter(dio: dio);
      });

      test(
        'chatgpt test',
        () async {
          // const route = '/detect';
          dioAdapter.onPost(baseUrl, (server) => server.reply(201, null),
              data: datas);
          response = await dio.post(baseUrl, data: datas);

          expect(response.statusCode, 201);

          dioAdapter.onPost(
              baseUrl,
              (server) => server.throws(401,
                  DioException(requestOptions: RequestOptions(path: baseUrl))));
        },
      );
    },
  );
}
