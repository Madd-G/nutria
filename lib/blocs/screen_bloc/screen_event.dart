part of 'screen_bloc.dart';

@immutable
abstract class ScreenEvent {}

@immutable
class ScreenEventGoToScanScreen extends ScreenEvent {}

@immutable
class ScreenEventGoToHomeScreen extends ScreenEvent {}

@immutable
class ScreenEventGoToProfileScreen extends ScreenEvent {}

@immutable
class ScreenEventGoToRegistrationScreen extends ScreenEvent {}

@immutable
class ScreenEventGoToLoginScreen extends ScreenEvent {}

@immutable
class ScreenEventGoToScreenController extends ScreenEvent {}

@immutable
class ScreenEventGoToListScreen extends ScreenEvent {}

@immutable
class ScreenEventGoToUserDataScreen extends ScreenEvent {}

@immutable
class ScreenEventGoToChangePasswordScreen extends ScreenEvent {}

@immutable
class ScreenEventGoToDetailScreen extends ScreenEvent {
  final Data data;

  ScreenEventGoToDetailScreen({required this.data});
}

@immutable
class ScreenEventGoToSearchScreen extends ScreenEvent {}

@immutable
class ScreenEventGoToPreviewScreen extends ScreenEvent {}

@immutable
class ScreenEventGoToDetailObjectScreen extends ScreenEvent {
  final String imagePath;

  ScreenEventGoToDetailObjectScreen({required this.imagePath});
}

@immutable
class ScreenEventGoToHistoryScreen extends ScreenEvent {}

@immutable
class ScreenEventGoToHistoryDetailScreen extends ScreenEvent {}
