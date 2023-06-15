part of 'article_bloc.dart';

@immutable
abstract class ArticleEvent {}

@immutable
class GetArticle extends ArticleEvent {}
