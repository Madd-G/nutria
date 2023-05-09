part of 'screen_bloc.dart';

@immutable
abstract class ScreenState {
  final String route;
  final int? index;
  final bool isLoading;
  final AuthError? authError;

  const ScreenState(
      {required this.isLoading,
      required this.route,
      this.index,
      this.authError});
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
      {required bool isLoading,
      AuthError? authError,
      required int index,
      required String route})
      : super(isLoading: isLoading, index: 0, route: '/scan');
}

class ScreenStateIsInHomeScreen extends ScreenState {
  const ScreenStateIsInHomeScreen(
      {required bool isLoading,
      AuthError? authError,
      required int index,
      required String route})
      : super(isLoading: isLoading, index: 1, route: '/home');
}

class ScreenStateIsInProfileScreen extends ScreenState {
  const ScreenStateIsInProfileScreen(
      {required bool isLoading,
      AuthError? authError,
      required int index,
      required String route})
      : super(isLoading: isLoading, index: 2, route: '/profile');
}

class ScreenStateIsInRegistrationScreen extends ScreenState {
  const ScreenStateIsInRegistrationScreen(
      {required bool isLoading, AuthError? authError, required String route})
      : super(isLoading: isLoading, route: '/registration');
}

class ScreenStateIsInLoginScreen extends ScreenState {
  const ScreenStateIsInLoginScreen(
      {required bool isLoading, AuthError? authError, required String route})
      : super(isLoading: isLoading, route: '/login');
}

class ScreenStateIsInScreenController extends ScreenState {
  const ScreenStateIsInScreenController(
      {required bool isLoading, AuthError? authError, required String route})
      : super(isLoading: isLoading, route: '/controller');
}
