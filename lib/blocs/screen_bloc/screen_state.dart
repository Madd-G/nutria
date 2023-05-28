part of 'screen_bloc.dart';

@immutable
abstract class ScreenState {
  final bool isLoading;
  final AuthError? authError;

  const ScreenState({required this.isLoading, this.authError});
}

// class ScreenStateInitial extends ScreenState {
//   final AuthBloc? authBloc;
//   StreamSubscription? streamSubscription;
//
//   @override
//   ScreenStateInitial({this.authBloc, required bool isLoading, AuthError? authError, required String route}) : super(isLoading: false, route: '') {
//     streamSubscription = authBloc!.stream.listen((state) {
//       if (state.isLogin == true ) {
//        authBloc!.add(const AuthEventInitial());
//       }
//     });
//
//   }
// }

class ScreenStateIsInScanScreen extends ScreenState {
  const ScreenStateIsInScanScreen(
      {required bool isLoading, AuthError? authError})
      : super(isLoading: isLoading);
}

class ScreenStateIsInHomeScreen extends ScreenState {
  const ScreenStateIsInHomeScreen(
      {required bool isLoading, AuthError? authError})
      : super(isLoading: isLoading);
}

class ScreenStateIsInProfileScreen extends ScreenState {
  const ScreenStateIsInProfileScreen(
      {required bool isLoading, AuthError? authError})
      : super(isLoading: isLoading);
}

class ScreenStateIsInRegistrationScreen extends ScreenState {
  const ScreenStateIsInRegistrationScreen(
      {required bool isLoading, AuthError? authError})
      : super(isLoading: isLoading);
}

class ScreenStateIsInLoginScreen extends ScreenState {
  const ScreenStateIsInLoginScreen(
      {required bool isLoading, AuthError? authError})
      : super(isLoading: isLoading);
}

class ScreenStateIsInScreenController extends ScreenState {
  const ScreenStateIsInScreenController(
      {required bool isLoading, AuthError? authError})
      : super(isLoading: isLoading);
}

class ScreenStateIsInUserDataScreen extends ScreenState {
  const ScreenStateIsInUserDataScreen(
      {required bool isLoading, AuthError? authError})
      : super(isLoading: isLoading);
}

class ScreenStateIsInChangePasswordScreen extends ScreenState {
  const ScreenStateIsInChangePasswordScreen(
      {required bool isLoading, AuthError? authError})
      : super(isLoading: isLoading);
}

class ScreenStateIsInListScreen extends ScreenState {
  const ScreenStateIsInListScreen(
      {required bool isLoading, AuthError? authError})
      : super(isLoading: isLoading);
}
