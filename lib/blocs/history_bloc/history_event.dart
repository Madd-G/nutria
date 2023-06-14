part of 'history_bloc.dart';

@immutable
abstract class HistoryEvent {}

@immutable
class AddHistory extends HistoryEvent {
  final List<Prediction> predResult;

  AddHistory({required this.predResult});
}

class GetHistoryEvent extends HistoryEvent {}

class GetAllHistoryEvent extends HistoryEvent {}
