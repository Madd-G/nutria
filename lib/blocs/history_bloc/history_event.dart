part of 'history_bloc.dart';

@immutable
abstract class HistoryEvent {}

@immutable
class AddHistory extends HistoryEvent {
  final List<PredictionModel> predResult;

  AddHistory({required this.predResult});
}
