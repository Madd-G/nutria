import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'bottom_nav_bar_event.dart';

part 'bottom_nav_bar_state.dart';

class BottomNavBarBloc extends Bloc<BottomNavBarEvent, BottomNavBarState> {
  BottomNavBarBloc() : super(const StateIsInInitial()) {
    on<EventGoToHomeScreen>((event, emit) {
      emit(const StateIsInHomeScreen(0));
    });
    on<EventGoToScanScreen>((event, emit) {
      emit(const StateIsInScanScreen(1));
    });
    on<EventGoToArticleScreen>((event, emit) {
      emit(const StateIsInArticleScreen(2));
    });
  }
}
