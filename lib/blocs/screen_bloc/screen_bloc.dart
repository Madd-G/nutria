import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nutria/models/models.dart';

import '../../utils/auth/auth_error.dart';
import '../blocs.dart';

part 'screen_event.dart';

part 'screen_state.dart';

class ScreenBloc extends Bloc<ScreenEvent, ScreenState> {
  ScreenBloc() : super(const ScreenStateIsInLoginScreen(isLoading: false)) {
    on<ScreenEventGoToScanScreen>((event, emit) {
      emit(const ScreenStateIsInScanScreen(isLoading: false));
    });
    on<ScreenEventGoToHomeScreen>((event, emit) {
      emit(const ScreenStateIsInHomeScreen(isLoading: false));
    });
    on<ScreenEventGoToArticleScreen>((event, emit) {
      final Article article = event.article;
      emit(ScreenStateIsInArticleScreen(isLoading: false, article: article));
    });

    on<ScreenEventGoToArticleListScreen>((event, emit) {
      emit(const ScreenStateIsInArticleListScreen(isLoading: false));
    });

    on<ScreenEventGoToRegistrationScreen>((event, emit) {
      emit(const ScreenStateIsInRegistrationScreen(isLoading: false));
    });
    on<ScreenEventGoToLoginScreen>((event, emit) {
      emit(const ScreenStateIsInLoginScreen(isLoading: false));
    });
    on<ScreenEventGoToScreenController>((event, emit) {
      emit(const ScreenStateIsInScreenController(isLoading: false));
    });

    on<ScreenEventGoToListScreen>((event, emit) {
      emit(const ScreenStateIsInListScreen(isLoading: false));
    });
    on<ScreenEventGoToDetailScreen>((event, emit) {
      final Data data = event.data;
      emit(ScreenStateIsInDetailScreen(isLoading: false, data: data));
    });
    on<ScreenEventGoToSearchScreen>((event, emit) {
      emit(const ScreenStateIsInSearchScreen(isLoading: false));
    });

    on<ScreenEventGoToPreviewScreen>((event, emit) {
      emit(const ScreenStateIsInPreviewScreen(isLoading: false));
    });
    on<ScreenEventGoToDetailObjectScreen>((event, emit) {
      final String imagePath = event.imagePath;
      emit(ScreenStateIsInDetailObjectScreen(
          isLoading: false, imagePath: imagePath));
    });
  }
}
