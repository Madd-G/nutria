part of 'bottom_nav_bar_bloc.dart';

@immutable
abstract class BottomNavBarState {
  final int index;

  const BottomNavBarState({required this.index});
}

@immutable
class StateIsInInitial extends BottomNavBarState {
  @override
  const StateIsInInitial() : super(index: 1);
}

@immutable
class StateIsInScanScreen extends BottomNavBarState {
  const StateIsInScanScreen(int idx) : super(index: 0);
}

@immutable
class StateIsInHomeScreen extends BottomNavBarState {
  const StateIsInHomeScreen(int idx) : super(index: 1);
}

@immutable
class StateIsInArticleScreen extends BottomNavBarState {
  const StateIsInArticleScreen(int idx) : super(index: 2);
}
