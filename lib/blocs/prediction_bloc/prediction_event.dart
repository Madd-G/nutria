part of 'prediction_bloc.dart';

@immutable
abstract class PredictionEvent {}

@immutable
class GetPrediction extends PredictionEvent {
  final String imagePath;

  GetPrediction({required this.imagePath});
}
