part of 'chatgpt_bloc.dart';

@immutable
abstract class ChatGPTEvent {}

class GetResult extends ChatGPTEvent {
  final String message;
  final String apiKey;

  GetResult({required this.message, required this.apiKey});
}

class SendMessage extends ChatGPTEvent {

}
