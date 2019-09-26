import 'dart:async';
import 'dart:convert';

import 'package:clean_news_ai/data/api/news_api.dart';
import 'package:flutter/foundation.dart';
import 'package:worker_manager/task.dart';
import 'package:worker_manager/worker_manager.dart';

import 'dto/answer.dart';
import 'dto/article.dart';

abstract class NetworkDataRepository {
  Stream<List<Article>> _streamWithArticles({@required String jsonData});

  Future<Stream<List<Article>>> getTopArticles({
    @required String category,
  });

  Future<Stream<List<Article>>> searchArticles({
    @required String keyWord,
  });

  factory NetworkDataRepository() => _NetworkDataRepositoryImpl();

  static List<Article> parseArticles(String jsonData) {
    final answer = Answer.fromMap(json.decode(jsonData));
    return answer.articles;
  }
}

class _NetworkDataRepositoryImpl implements NetworkDataRepository {
  final _api = API();
  static final _NetworkDataRepositoryImpl _repositoryImpl = _NetworkDataRepositoryImpl._internal();

  factory _NetworkDataRepositoryImpl() => _repositoryImpl;

  _NetworkDataRepositoryImpl._internal();

  @override
  Stream<List<Article>> _streamWithArticles({String jsonData}) {
    final task = Task<String, List<Article>>(function: parseArticles, bundle: jsonData);
    return Executor().addTask(task: task).handleError((error) {
      return Stream.error(error);
    });
  }

  @override
  Future<Stream<List<Article>>> getTopArticles({String category}) {
    return _api.getTopArticles(category: category).catchError((error) {
      return Stream.error(error);
    }).then((jsonData) {
      return _streamWithArticles(jsonData: jsonData);
    });
  }

  @override
  Future<Stream<List<Article>>> searchArticles({String keyWord}) {
    return _api.searchArticles(keyWord: keyWord).catchError((error) {
      return Stream.error(error);
    }).then((jsonData) {
      return _streamWithArticles(jsonData: jsonData);
    });
  }

  static List<Article> parseArticles(String jsonData) {
    final answer = Answer.fromMap(json.decode(jsonData));
    return answer.articles;
  }
}
