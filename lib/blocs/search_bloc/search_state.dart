part of 'search_bloc.dart';

@immutable
abstract class SearchState {}

@immutable
class SearchInitial extends SearchState {}

@immutable
class NotSearchingItemState extends SearchState {}

@immutable
class SearchingItemState extends SearchState {}

@immutable
class ItemNotFound extends SearchState {}

@immutable
class ItemExistState extends SearchState {
  final List<Data>? items;

  ItemExistState({this.items});
}

@immutable
class ErrorsState extends SearchState {
  final String errorMessage;

  ErrorsState(this.errorMessage);
}



