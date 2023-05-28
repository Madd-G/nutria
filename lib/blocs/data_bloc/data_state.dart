part of 'data_bloc.dart';

@immutable
abstract class DataState {}

class DataInitial extends DataState {}

@immutable
class LoadingState extends DataState {}

@immutable
class RecommendationsSuccessState extends DataState {
  final DataModel recommendations;

  RecommendationsSuccessState(this.recommendations);
}

@immutable
class FruitsSuccessState extends DataState {
  final DataModel fruits;

  FruitsSuccessState(this.fruits);
}

@immutable
class VegetablesSuccessState extends DataState {
  final DataModel vegetables;

  VegetablesSuccessState(this.vegetables);
}

@immutable
class ErrorState extends DataState {
  final Object error;
  final String errorMessage;

  ErrorState(this.error, this.errorMessage);
}
