part of 'recommendations_bloc.dart';

@immutable
abstract class RecommendationsEvent {}

@immutable
class GetRecommendations extends RecommendationsEvent {}
