import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'bottom_nav_bar_event.dart';

part 'bottom_nav_bar_state.dart';

class BottomNavBarBloc extends Bloc<ScreenEvent, ScreenState> {
  BottomNavBarBloc() : super(const InitialState()) {
    on<ScanEvent>((event, emit) {
      emit(const ScanState());
    });
    on<HomeEvent>((event, emit) {
      emit(const HomeState());
    });
    on<ProfileEvent>((event, emit) {
      emit(const ProfileState());
    });
  }
}
