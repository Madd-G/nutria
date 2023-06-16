part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

@immutable
class AuthInitial extends AuthState {}

@immutable
class AuthLoading extends AuthState {}

@immutable
class AuthSuccess extends AuthState {
  // final String msg;
  //
  // AuthSuccess(this.msg);
}

@immutable
class AuthFailure extends AuthState {
  // final String msg;
  //
  // AuthFailure(this.msg);
}

// part of 'auth_bloc.dart';
//
// @immutable
// abstract class AuthState {}
//
// @immutable
// class AuthInitial extends AuthState {}
//
// @immutable
// class AuthLoading extends AuthState {}
//
// @immutable
// class AuthSuccess extends AuthState {
//   // final String msg;
//   //
//   // AuthSuccess(this.msg);
// }
//
// @immutable
// class AuthFailed extends AuthState {
//   // final String msg;
//   //
//   // AuthFailure(this.msg);
// }
