part of 'prediction_bloc.dart';

@immutable
abstract class PredictionState {}

@immutable
class PredictionInitial extends PredictionState {}

@immutable
class PredictionLoadingState extends PredictionState {}

@immutable
class PredictionSuccessState extends PredictionState {
  final PredictionModel predictionModel;

  PredictionSuccessState(this.predictionModel);
}

@immutable
class PredictionErrorState extends PredictionState {
  final Object error;
  final String errorMessage;

  PredictionErrorState(this.error, this.errorMessage);
}
