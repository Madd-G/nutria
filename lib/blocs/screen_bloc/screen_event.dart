part of 'screen_bloc.dart';

@immutable
abstract class ScreenEvent {}

class ScanEvent extends ScreenEvent {}

class HomeEvent extends ScreenEvent {}

class ProfileEvent extends ScreenEvent {}
