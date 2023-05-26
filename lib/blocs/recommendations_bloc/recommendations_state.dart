part of 'recommendations_bloc.dart';

@immutable
abstract class RecommendationsState {}

// class RecommendationsInitial extends RecommendationsState {}

@immutable
class RecommendationsLoadingState extends RecommendationsState {}

@immutable
class RecommendationsSuccessState extends RecommendationsState {
  final RecommendationsModel recommendations;

  RecommendationsSuccessState(this.recommendations);
}

@immutable
class RecommendationsErrorState extends RecommendationsState {
  final Object error;
  final String errorMessage;

  RecommendationsErrorState(this.error, this.errorMessage);
}
