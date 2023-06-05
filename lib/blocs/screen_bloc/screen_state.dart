part of 'screen_bloc.dart';

@immutable
abstract class ScreenState {
  final bool isLoading;
  final AuthError? authError;

  const ScreenState({required this.isLoading, this.authError});
}

@immutable
class ScreenStateIsInScanScreen extends ScreenState {
  const ScreenStateIsInScanScreen(
      {required bool isLoading, AuthError? authError})
      : super(isLoading: isLoading);
}

@immutable
class ScreenStateIsInHomeScreen extends ScreenState {
  const ScreenStateIsInHomeScreen(
      {required bool isLoading, AuthError? authError})
      : super(isLoading: isLoading);
}

@immutable
class ScreenStateIsInProfileScreen extends ScreenState {
  const ScreenStateIsInProfileScreen(
      {required bool isLoading, AuthError? authError})
      : super(isLoading: isLoading);
}

@immutable
class ScreenStateIsInRegistrationScreen extends ScreenState {
  const ScreenStateIsInRegistrationScreen(
      {required bool isLoading, AuthError? authError})
      : super(isLoading: isLoading);
}

@immutable
class ScreenStateIsInLoginScreen extends ScreenState {
  const ScreenStateIsInLoginScreen(
      {required bool isLoading, AuthError? authError})
      : super(isLoading: isLoading);
}

@immutable
class ScreenStateIsInScreenController extends ScreenState {
  const ScreenStateIsInScreenController(
      {required bool isLoading, AuthError? authError})
      : super(isLoading: isLoading);
}

@immutable
class ScreenStateIsInUserDataScreen extends ScreenState {
  const ScreenStateIsInUserDataScreen(
      {required bool isLoading, AuthError? authError})
      : super(isLoading: isLoading);
}

@immutable
class ScreenStateIsInChangePasswordScreen extends ScreenState {
  const ScreenStateIsInChangePasswordScreen(
      {required bool isLoading, AuthError? authError})
      : super(isLoading: isLoading);
}

@immutable
class ScreenStateIsInListScreen extends ScreenState {
  const ScreenStateIsInListScreen(
      {required bool isLoading, AuthError? authError})
      : super(isLoading: isLoading);
}

class ScreenStateIsInDetailScreen extends ScreenState {
  final Data data;

  const ScreenStateIsInDetailScreen(
      {required bool isLoading, AuthError? authError, required this.data})
      : super(isLoading: isLoading);
}

@immutable
class ScreenStateIsInSearchScreen extends ScreenState {
  const ScreenStateIsInSearchScreen(
      {required bool isLoading, AuthError? authError})
      : super(isLoading: isLoading);
}
