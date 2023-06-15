part of 'article_bloc.dart';

@immutable
abstract class ArticleState {}

class ArticleInitial extends ArticleState {}

@immutable
class ArticleLoadingState extends ArticleState {}

@immutable
class ArticleSuccessState extends ArticleState {
  final ArticleModel article;

  ArticleSuccessState({required this.article});
}

@immutable
class ArticleErrorState extends ArticleState {
  final Object error;
  final String errorMessage;

  ArticleErrorState(this.error, this.errorMessage);
}