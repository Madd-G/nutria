part of 'auth_cubit.dart';

@immutable
abstract class AuthEvent {}

@immutable
class AuthEventInitial implements AuthEvent {
  const AuthEventInitial();
}

@immutable
class AuthEventLogIn implements AuthEvent {
  final String email;
  final String password;

  const AuthEventLogIn({
    required this.email,
    required this.password,
  });
}

@immutable
class AuthEventLoginWithApple implements AuthEvent {
  const AuthEventLoginWithApple();
}

@immutable
class AuthEventLoginWithGoogle implements AuthEvent {
  const AuthEventLoginWithGoogle();
}

@immutable
class AuthEventLogOut implements AuthEvent {
  const AuthEventLogOut();
}

@immutable
class AuthEventGoToLoginView implements AuthEvent {
  const AuthEventGoToLoginView();
}

@immutable
class AuthEventGoToRegistrationView implements AuthEvent {
  const AuthEventGoToRegistrationView();
}

@immutable
class AuthEventRegister implements AuthEvent {
  final String email;
  final String password;

  const AuthEventRegister({
    required this.email,
    required this.password,
  });
}

@immutable
class AuthEventDeleteAccount implements AuthEvent {
  const AuthEventDeleteAccount();
}
