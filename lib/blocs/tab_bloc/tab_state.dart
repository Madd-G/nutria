part of 'tab_bloc.dart';

@immutable
abstract class TabState {}

@immutable
class TabInitial extends TabState {}

@immutable
class TabStateIsInFruitTab extends TabState {}

@immutable
class TabStateIsInVegetableTab extends TabState {}
