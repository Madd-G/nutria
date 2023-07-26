import 'package:flutter_test/flutter_test.dart';

class MockChatGpt {
  bool shouldFail = false;

  Future<String> generateResponse(String message) async {
    if (shouldFail) {
      throw Exception('ChatGPT Error: Failed to generate response.');
    }
    return "$message";
  }
}

class ChatService {
  final MockChatGpt chatGpt;

  ChatService(this.chatGpt);

  Future<String> sendMessage(String message) async {
    return await chatGpt.generateResponse(message);
  }
}

void main() async {
  late ChatService chatService;
  late MockChatGpt mockChatGpt;

  setUp(() {
    mockChatGpt = MockChatGpt();
    chatService = ChatService(mockChatGpt);
  });

  test(
    'Berhasil mendapatkan response',
    () async {
      final response = await chatService.sendMessage("Hello");
      expect(response, "Hello");
    },
  );

  test('Gagal mendapatkan response', () async {
    mockChatGpt.shouldFail = true;
    final chatService = ChatService(mockChatGpt);

    final responseFuture = chatService.sendMessage("Error message.");

    expectLater(responseFuture, throwsA(isA<Exception>()));
  });
}
