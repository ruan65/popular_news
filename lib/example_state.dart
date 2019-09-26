import 'package:clean_news_ai/domain/models/news_article.dart';
import 'package:meta/meta.dart';

mixin ExampleStateData {
  final articles = <ArticleModel>[];
}

@immutable
abstract class ExampleState with ExampleStateData {
  factory ExampleState.initial() => InitialExampleState();
}

class InitialExampleState with ExampleStateData implements ExampleState {}
