import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../utils/auth/auth_error.dart';

part 'auth_state.dart';

part 'auth_event.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthInitial());

  goToRegistrationView() {
    emit(const AuthStateIsInRegistrationView());
  }

  goToLoginView() {
    emit(const AuthStateIsInLoginView());
  }

  Future signInWithEmail(email, password) async {
    try {
      final userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      emit(
        AuthFailure(
          authError: AuthError.from(e),
        ),
      );
    }
  }

  Future registerWithEmail(email, password) async {
    try {
      // final userCredential =
      //     await FirebaseAuth.instance.WithEmailAndPassword(
      //   email: email,
      //   password: password,
      // );
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      emit(
        AuthFailure(
          authError: AuthError.from(e),
        ),
      );
    }
  }

  Future<UserCredential> signInWithGoogle(context) async {
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future signInWithApple(context) async {
    final rawNonce = generateNonce();
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );
    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
    );
    return await FirebaseAuth.instance.signInWithCredential(oauthCredential);
  }
}
