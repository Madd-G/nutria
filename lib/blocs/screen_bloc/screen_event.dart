part of 'screen_bloc.dart';

@immutable
abstract class ScreenEvent {}

class ScreenEventGoToScanScreen extends ScreenEvent {}

class ScreenEventGoToHomeScreen extends ScreenEvent {}

class ScreenEventGoToProfileScreen extends ScreenEvent {}
