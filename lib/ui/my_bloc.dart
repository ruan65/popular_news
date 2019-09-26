import 'dart:async';

import 'package:clean_news_ai/domain/domain_repository.dart';
import 'package:clean_news_ai/domain/models/news_article.dart';

class Bloc {
  final _articlesBroadcaster = StreamController<List<ArticleModel>>.broadcast();
  Stream<List<ArticleModel>> get articlesStream => _articlesBroadcaster.stream;

  final currentArticles = <ArticleModel>[];

  void fetchData() {
    Stream.fromFuture(DomainRepository().getTopArticles(category: 'sport').then((articlesStream) {
      articlesStream.listen((articles) {
        currentArticles.clear();
        currentArticles.addAll(articles);
        _articlesBroadcaster.add(articles);
      });
    }));
  }

  disposeBloc() {
    _articlesBroadcaster.close();
  }
}
