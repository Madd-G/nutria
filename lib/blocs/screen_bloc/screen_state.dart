part of 'screen_bloc.dart';

@immutable
abstract class ScreenState {
  final String route;
  final int? index;
  const ScreenState({required this.route, this.index});
}

class InitialState extends ScreenState {
  @override
  const InitialState() : super(index: 1, route: '/');
}

class ScreenStateIsInScanScreen extends ScreenState {
  const ScreenStateIsInScanScreen({required super.index, required super.route});
}

class ScreenStateIsInHomeScreen extends ScreenState {
  const ScreenStateIsInHomeScreen({required super.index, required super.route});
}

class ScreenStateIsInProfileScreen extends ScreenState {
  const ScreenStateIsInProfileScreen({required super.index, required super.route});
}
