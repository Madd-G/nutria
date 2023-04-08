part of 'bottom_nav_bar_bloc.dart';

@immutable
abstract class ScreenState {
  final int index;

  const ScreenState({required this.index});
}

class InitialState extends ScreenState {
  @override
  const InitialState() : super(index: 1);
}

class ScanState extends ScreenState {
  const ScanState() : super(index: 0);
}

class HomeState extends ScreenState {
  const HomeState() : super(index: 1);
}

class ProfileState extends ScreenState {
  const ProfileState() : super(index: 2);
}
