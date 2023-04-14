part of 'recommendations_bloc.dart';

@immutable
abstract class RecommendationsState {}

// class RecommendationsInitial extends RecommendationsState {}

class LoadingState extends RecommendationsState {
}

class SuccessState extends RecommendationsState {
  final RecommendationsModel recommendations;

  SuccessState(this.recommendations);
}

class ErrorState extends RecommendationsState {
  final Object error;
  final String errorMessage;

  ErrorState(this.error, this.errorMessage);
}
