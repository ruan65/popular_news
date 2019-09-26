import 'dart:async';

import 'package:clean_news_ai/data/dto/article.dart';
import 'package:clean_news_ai/data/network_data_repository.dart';
import 'package:clean_news_ai/domain/models/news_article.dart';
import 'package:flutter/foundation.dart';

abstract class DomainRepository {
  Future<Stream<List<ArticleModel>>> getTopArticles({
    @required String category,
  });

  Future<Stream<List<Article>>> searchArticles({
    @required String keyWord,
  });

  Future<Stream<List<Article>>> getSavedArticles({
    @required String keyWord,
  });

  void saveArticle({@required Article article});

  void deleteArticle({@required Article article});

  factory DomainRepository() => _DomainRepositoryImpl();
}

class _DomainRepositoryImpl implements DomainRepository {
  static final _DomainRepositoryImpl _repositoryImpl = _DomainRepositoryImpl._internal();

  factory _DomainRepositoryImpl() => _repositoryImpl;

  _DomainRepositoryImpl._internal();

  @override
  Future<Stream<List<ArticleModel>>> getTopArticles({String category}) async =>
      (await NetworkDataRepository().getTopArticles(category: category)).map((articles) =>
          articles.map((article) => ArticleModel(article: article, isSaved: false)).toList());

  @override
  Future<Stream<List<Article>>> searchArticles({String keyWord}) async =>
      await NetworkDataRepository().searchArticles(keyWord: keyWord);

  @override
  Future<Stream<List<Article>>> getSavedArticles({String keyWord}) {
    // TODO: implement getSavedArticles
    return null;
  }

  @override
  void saveArticle({Article article}) {
    // TODO: implement saveArticle
  }

  @override
  void deleteArticle({Article article}) {
    // TODO: implement deleteArticle
  }
}
