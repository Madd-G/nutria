import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../../utils/auth/auth_error.dart';
import '../screen_bloc/screen_bloc.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  ScreenBloc screenBloc = ScreenBloc();

  AuthBloc() : super(const AuthStateLoggedOut(isLoading: false)) {
    on<AuthEventInitial>(
      (event, emit) async {
        // get the current user
        final user = FirebaseAuth.instance.currentUser;
        if (user == null) {
          emit(
            const AuthStateLoggedOut(
              isLoading: false,
            ),
          );
        } else {
          emit(
            AuthStateLoggedIn(
              isLoading: false,
              user: user,
            ),
          );
        }
      },
    );

    on<AuthEventRegister>(
      (event, emit) async {
        // start loading
        emit(
          const AuthStateIsInRegistrationView(
            isLoading: true,
          ),
        );
        final email = event.email;
        final password = event.password;
        try {
          // create the user
          final credentials =
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email,
            password: password,
          );
          emit(
            AuthStateLoggedIn(
              isLoading: false,
              user: credentials.user!,
            ),
          );
        } on FirebaseAuthException catch (e) {
          emit(
            AuthStateIsInRegistrationView(
              isLoading: false,
              authError: AuthError.from(e),
            ),
          );
        }
      },
    );

    on<AuthEventLogIn>(
      (event, emit) async {
        emit(
          const AuthStateLoggedOut(
            isLoading: true,
          ),
        );
        // log the user in
        try {
          final email = event.email;
          final password = event.password;
          final userCredential =
              await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email,
            password: password,
          );
          final user = userCredential.user!;
          emit(
            const AuthStateLoggedOut(
              isLoading: false,
            ),
          );
          emit(
            AuthStateLoggedIn(
              isLoading: false,
              user: user,
            ),
          );
        } on FirebaseAuthException catch (e) {
          emit(
            AuthStateLoggedOut(
              isLoading: false,
              authError: AuthError.from(e),
            ),
          );
        }
      },
    );

    on<AuthEventLogOut>(
      (event, emit) async {
        // start loading
        emit(
          const AuthStateLoggedOut(
            isLoading: true,
          ),
        );
        // log the user out
        await FirebaseAuth.instance.signOut();
        // log the user out in the UI as well
        emit(
          const AuthStateLoggedOut(
            isLoading: false,
          ),
        );
      },
    );
    on<AuthEventDeleteAccount>(
      (event, emit) async {
        final user = FirebaseAuth.instance.currentUser;
        // log the user out if we don't have a current user
        if (user == null) {
          emit(
            const AuthStateLoggedOut(
              isLoading: false,
            ),
          );
          return;
        }
        // start loading
        emit(
          AuthStateLoggedIn(
            isLoading: true,
            user: user,
          ),
        );
        try {
          // delete the user
          await user.delete();
          // log the user out
          await FirebaseAuth.instance.signOut();
          // log the user out in the UI as well
          emit(
            const AuthStateLoggedOut(
              isLoading: false,
            ),
          );
        } on FirebaseAuthException catch (e) {
          emit(
            AuthStateLoggedIn(
              isLoading: false,
              user: user,
              authError: AuthError.from(e),
            ),
          );
        } on FirebaseException {
          emit(
            const AuthStateLoggedOut(
              isLoading: false,
            ),
          );
        }
      },
    );
  }
}
