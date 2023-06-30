part of 'chatgpt_bloc.dart';

@immutable
abstract class ChatGPTState {}

class ChatGPTInitial extends ChatGPTState {}

class ChatGPTIsLoading extends ChatGPTState {}

class ChatGPTIsSuccess extends ChatGPTState {
  final String result;

  ChatGPTIsSuccess({required this.result});
}
