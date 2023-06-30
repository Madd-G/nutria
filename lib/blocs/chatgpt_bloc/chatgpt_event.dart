part of 'chatgpt_bloc.dart';

@immutable
abstract class ChatGPTEvent {}

class GetResult extends ChatGPTEvent {
  final String message;

  GetResult({required this.message});
}

class SendMessage extends ChatGPTEvent {

}
