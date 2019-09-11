import 'dart:async';
import 'dart:convert';

import 'package:clean_news_ai/data/api/news_api.dart';
import 'package:flutter/foundation.dart';
import 'package:worker_manager/task.dart';
import 'package:worker_manager/worker_manager.dart';

import 'models/answer.dart';
import 'models/article.dart';

abstract class DataRepository {
  Stream<List<Article>> _streamWithArticles({@required String jsonData});

  Future<Stream<List<Article>>> getTopArticles({
    @required String category,
  });

  Future<Stream<List<Article>>> searchArticles({
    @required String keyWord,
  });

  factory DataRepository() => _DataRepositoryImpl();
}

class _DataRepositoryImpl implements DataRepository {
  final _api = API();
  static final _DataRepositoryImpl _repositoryImpl = _DataRepositoryImpl._internal();

  factory _DataRepositoryImpl() => _repositoryImpl;

  _DataRepositoryImpl._internal();

  @override
  Stream<List<Article>> _streamWithArticles({String jsonData}) {
    final task = Task<String, List<Article>>(function: parseArticles, bundle: jsonData);
    Executor().addTask(task: task);
    return Executor().resultOf(task: task);
  }

  @override
  Future<Stream<List<Article>>> getTopArticles({String category}) async {
    final jsonData = await _api.getTopArticles(category: category);
    return _streamWithArticles(jsonData: jsonData);
  }

  @override
  Future<Stream<List<Article>>> searchArticles({String keyWord}) async {
    final jsonData = await _api.searchArticles(keyWord: keyWord);
    return _streamWithArticles(jsonData: jsonData);
  }

  @override
  Future<Stream<List<Article>>> savedArticles({String uuid}) {
    // TODO: implement savedArticles
    return null;
  }
}

List<Article> parseArticles(String jsonData) {
  final answer = Answer.fromMap(json.decode(jsonData));
  return answer.articles;
}
