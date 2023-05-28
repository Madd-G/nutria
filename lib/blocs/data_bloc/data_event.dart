part of 'data_bloc.dart';

@immutable
abstract class DataEvent {}

@immutable
class GetRecommendations extends DataEvent {}

@immutable
class GetFruits extends DataEvent {}

@immutable
class GetVegetables extends DataEvent {}
