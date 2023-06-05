part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}

@immutable
class SearchItemEvent extends SearchEvent {
  final String searchedWord;

  SearchItemEvent({required this.searchedWord});
}
