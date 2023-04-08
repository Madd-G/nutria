part of 'bottom_nav_bar_bloc.dart';

@immutable
abstract class ScreenEvent {}

class ScanEvent extends ScreenEvent {}

class HomeEvent extends ScreenEvent {}

class ProfileEvent extends ScreenEvent {}
