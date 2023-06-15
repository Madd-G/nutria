part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}

@immutable
class SearchEventInitial extends SearchEvent {}

@immutable
class SearchItemEvent extends SearchEvent {
  final String? searchedItem;

  SearchItemEvent({this.searchedItem});
}
