import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;

part 'chatgpt_event.dart';

part 'chatgpt_state.dart';

class ChatGPTBloc extends Bloc<ChatGPTEvent, ChatGPTState> {
  ChatGPTBloc() : super(ChatGPTInitial()) {
    on<GetResult>((event, emit) async {
      emit(ChatGPTIsLoading());
      const SpinKitThreeBounce(
        color: Colors.black,
        size: 18,
      );
      String result = await sendMessageToChatGpt(event.message, event.apiKey);

      emit(ChatGPTIsSuccess(result: result));
    });
  }

  Future<String> sendMessageToChatGpt(String message, String apiKey) async {
    Uri uri = Uri.parse("https://api.openai.com/v1/chat/completions");

    Map<String, dynamic> body = {
      "model": "gpt-3.5-turbo",
      "messages": [
        {"role": "user", "content": message}
      ],
    };

    final response = await http.post(
      uri,
      headers: {
        "Content-Type": "application/json",
        "Authorization":
            "Bearer $apiKey",
      },
      body: json.encode(body),
    );

    Map<String, dynamic> parsedResponse = json.decode(response.body);

    String reply = parsedResponse['choices'][0]['message']['content'];
    return reply;
  }
}
