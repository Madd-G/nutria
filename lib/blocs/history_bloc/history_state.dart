part of 'history_bloc.dart';

@immutable
abstract class HistoryState {}

@immutable
class HistoryInitial extends HistoryState {}

class HistoryLoading extends HistoryState {}

class HistorySuccessState extends HistoryState {
  final List<Prediction> historyModel;
  HistorySuccessState({required this.historyModel});
}


