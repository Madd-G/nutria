part of 'screen_bloc.dart';

@immutable
abstract class ScreenEvent {}

class ScreenEventGoToScanScreen extends ScreenEvent {}

class ScreenEventGoToHomeScreen extends ScreenEvent {}

class ScreenEventGoToProfileScreen extends ScreenEvent {}

class ScreenEventGoToRegistrationScreen extends ScreenEvent {}

class ScreenEventGoToLoginScreen extends ScreenEvent {}

class ScreenEventGoToScreenController extends ScreenEvent {}

class ScreenEventIsInUserDataScreen extends ScreenEvent {}

class ScreenEventIsInChangePasswordScreen extends ScreenEvent {}
