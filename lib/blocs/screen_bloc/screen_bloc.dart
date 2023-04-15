import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'screen_event.dart';

part 'screen_state.dart';

class ScreenBloc extends Bloc<ScreenEvent, ScreenState> {
  ScreenBloc() : super(const InitialState()) {
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
