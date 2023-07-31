part of 'prediction_bloc.dart';

@immutable
abstract class PredictionEvent {}

@immutable
class GetPrediction extends PredictionEvent {
  final String imagePath;
  final String baseUrl;

  GetPrediction({required this.imagePath, required this.baseUrl});
}

class ShowResult extends PredictionEvent {}
