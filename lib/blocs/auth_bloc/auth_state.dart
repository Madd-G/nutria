part of 'auth_cubit.dart';

@immutable
abstract class AuthState {
  final AuthError? authError;

  const AuthState({
    this.authError,
  });
}

@immutable
class AuthInitial extends AuthState {
  const AuthInitial({super.authError});
}

@immutable
class AuthLoading extends AuthState {
  const AuthLoading({super.authError});
}

@immutable
class AuthSuccess extends AuthState {
  const AuthSuccess({super.authError});
}

@immutable
class AuthFailure extends AuthState {
  const AuthFailure({super.authError});
}

@immutable
class AuthStateIsInRegistrationView extends AuthState {
  const AuthStateIsInRegistrationView({super.authError});
}

@immutable
class AuthStateIsInLoginView extends AuthState {
  const AuthStateIsInLoginView({super.authError});
}
