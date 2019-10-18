import 'dart:async';

import 'package:clean_news_ai/data/api/news_api.dart';
import 'package:flutter/foundation.dart';

abstract class NetworkDataRepository {
  Future<String> getTopArticles({
    @required String category,
  });

  Future<String> searchArticles({
    @required String keyWord,
  });

  factory NetworkDataRepository.newsAPI() => _NewsAPIRepository();
}

class _NewsAPIRepository implements NetworkDataRepository {
  API _api = API.newsAPI();
  static final _NewsAPIRepository _repositoryImpl = _NewsAPIRepository._internal();

  factory _NewsAPIRepository() => _repositoryImpl;

  _NewsAPIRepository._internal();

  @override
  Future<String> getTopArticles({String category}) async =>
      await _api.getTopArticles(category: category);

  @override
  Future<String> searchArticles({String keyWord}) async =>
      await _api.searchArticles(keyWord: keyWord);
}
