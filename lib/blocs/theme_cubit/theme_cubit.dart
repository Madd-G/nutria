import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../theme.dart';

class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit({required this.initialTheme}) : super(initialTheme);
  final ThemeData initialTheme;

  void switchTheme() {
    state == AppTheme.lightTheme
        ? emit(AppTheme.darkTheme)
        : emit(AppTheme.lightTheme);
  }
}
