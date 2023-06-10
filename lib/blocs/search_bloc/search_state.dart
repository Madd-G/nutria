part of 'search_bloc.dart';

@immutable
abstract class SearchState {}

@immutable
class SearchInitial extends SearchState {}

@immutable
class NotSearchingWordState extends SearchState {}

@immutable
class SearchingWordState extends SearchState {}

@immutable
class WordNotFound extends SearchState {}

@immutable
class WordExistState extends SearchState {
  final List<Data>? words;

  WordExistState({this.words});
}

@immutable
class ErrorsState extends SearchState {
  final String errorMessage;

  ErrorsState(this.errorMessage);
}



