part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

@immutable
class AuthInitial extends AuthState {}

@immutable
class AuthLoading extends AuthState {}

@immutable
class AuthSuccess extends AuthState {}

@immutable
class AuthFailure extends AuthState {}
