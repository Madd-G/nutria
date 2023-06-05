import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/data_model.dart';
import '../../utils/auth/auth_error.dart';
import '../blocs.dart';

part 'screen_event.dart';

part 'screen_state.dart';

class ScreenBloc extends Bloc<ScreenEvent, ScreenState> {
  ScreenBloc() : super(const ScreenStateIsInLoginScreen(isLoading: false)) {
    on<ScreenEventGoToScanScreen>((event, emit) {
      emit(const ScreenStateIsInScanScreen(isLoading: false));
    });
    on<ScreenEventGoToHomeScreen>((event, emit) {
      emit(const ScreenStateIsInHomeScreen(isLoading: false));
    });
    on<ScreenEventGoToProfileScreen>((event, emit) {
      emit(const ScreenStateIsInProfileScreen(isLoading: false));
    });

    on<ScreenEventGoToRegistrationScreen>((event, emit) {
      emit(const ScreenStateIsInRegistrationScreen(isLoading: false));
    });
    on<ScreenEventGoToLoginScreen>((event, emit) {
      emit(const ScreenStateIsInLoginScreen(isLoading: false));
    });
    on<ScreenEventGoToScreenController>((event, emit) {
      emit(const ScreenStateIsInScreenController(isLoading: false));
    });

    on<ScreenEventGoToListScreen>((event, emit) {
      emit(const ScreenStateIsInListScreen(isLoading: false));
    });

    on<ScreenEventGoToUserDataScreen>((event, emit) {
      emit(const ScreenStateIsInUserDataScreen(isLoading: false));
    });
    on<ScreenEventGoToChangePasswordScreen>((event, emit) {
      emit(const ScreenStateIsInChangePasswordScreen(isLoading: false));
    });
    on<ScreenEventGoToDetailScreen>((event, emit) {
      final Data data = event.data;
      emit(ScreenStateIsInDetailScreen(isLoading: false, data: data));
    });
    on<ScreenEventGoToSearchScreen>((event, emit) {
      emit(const ScreenStateIsInSearchScreen(isLoading: false));
    });
  }
}
