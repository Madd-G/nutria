import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../utils/auth/auth_error.dart';
import '../bloc_imports.dart';

part 'screen_event.dart';

part 'screen_state.dart';

class ScreenBloc extends Bloc<ScreenEvent, ScreenState> {
  ScreenBloc()
      : super(const ScreenStateIsInLoginScreen(
            isLoading: false, route: '/login')) {
    on<ScreenEventGoToScanScreen>((event, emit) {
      emit(const ScreenStateIsInScanScreen(
          index: 0, route: '/scan', isLoading: false));
    });
    on<ScreenEventGoToHomeScreen>((event, emit) {
      emit(const ScreenStateIsInHomeScreen(
          index: 1, route: '/home', isLoading: false));
    });
    on<ScreenEventGoToProfileScreen>((event, emit) {
      emit(const ScreenStateIsInProfileScreen(
          index: 2, route: '/profile', isLoading: false));
    });

    on<ScreenEventGoToRegistrationScreen>((event, emit) {
      emit(const ScreenStateIsInRegistrationScreen(
          route: '/registration', isLoading: false));
    });
    on<ScreenEventGoToLoginScreen>((event, emit) {
      emit(const ScreenStateIsInLoginScreen(route: '/login', isLoading: false));
    });
    on<ScreenEventGoToScreenController>((event, emit) {
      emit(const ScreenStateIsInScreenController(
          route: '/controller', isLoading: false));
    });
  }

  @override
  Future<void> close() {
    // dispose
    return super.close();
  }
}
