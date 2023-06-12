part of 'history_bloc.dart';

@immutable
abstract class HistoryState {}

@immutable
class HistoryInitial extends HistoryState {}

class HistoryLoading extends HistoryState {}

class GetHistory extends HistoryState {
  final List<PredictionModel>? predictionModel;
  GetHistory({required this.predictionModel});
}
