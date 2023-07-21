part of 'bottom_nav_bar_bloc.dart';

@immutable
abstract class BottomNavBarEvent {}

@immutable
class EventGoToHomeScreen extends BottomNavBarEvent {}

@immutable
class EventGoToScanScreen extends BottomNavBarEvent {}

@immutable
class EventGoToArticleScreen extends BottomNavBarEvent {}
