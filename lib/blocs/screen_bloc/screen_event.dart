part of 'screen_bloc.dart';

@immutable
abstract class ScreenEvent {}

@immutable
class ScreenEventGoToScanScreen extends ScreenEvent {}

@immutable
class ScreenEventGoToHomeScreen extends ScreenEvent {}

@immutable
class ScreenEventGoToArticleScreen extends ScreenEvent {
  final Article article;

  ScreenEventGoToArticleScreen({required this.article});
}

@immutable
class ScreenEventGoToArticleListScreen extends ScreenEvent {}

@immutable
class ScreenEventGoToRegistrationScreen extends ScreenEvent {}

@immutable
class ScreenEventGoToLoginScreen extends ScreenEvent {}

@immutable
class ScreenEventGoToScreenController extends ScreenEvent {}

@immutable
class ScreenEventGoToListScreen extends ScreenEvent {}

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
