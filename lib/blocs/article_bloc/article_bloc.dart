import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/models.dart';
import '../../services/services.dart';

part 'article_event.dart';

part 'article_state.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  ArticleBloc() : super(ArticleInitial()) {
    final ApiService service = ApiService();
    on<GetArticle>((event, emit) async{
      try {
        emit(ArticleLoadingState());
        final ArticleModel result = await service.fetchArticles();
        emit(ArticleSuccessState(article: result));
      } catch (e) {
        emit(ArticleErrorState(e, e.toString()));
      }
    });
  }
}
