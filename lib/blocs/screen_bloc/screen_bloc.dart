import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'screen_event.dart';

part 'screen_state.dart';

class ScreenBloc extends Bloc<ScreenEvent, ScreenState> {
  ScreenBloc() : super(const ScreenStateIsInHomeScreen(index: 1, route: '/')) {
    on<ScreenEventGoToScanScreen>((event, emit) {
      emit(const ScreenStateIsInScanScreen(index: 0, route: '/scan'));
    });
    on<ScreenEventGoToHomeScreen>((event, emit) {
      emit(const ScreenStateIsInHomeScreen(index: 1, route: '/home'));
    });
    on<ScreenEventGoToProfileScreen>((event, emit) {
      emit(const ScreenStateIsInProfileScreen(index: 2, route: '/profile'));
    });
  }
}
