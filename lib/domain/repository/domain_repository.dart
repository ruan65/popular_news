import 'dart:async';
import 'dart:convert';
import 'dart:core';

import 'package:clean_news_ai/data/api/network_data_repository.dart';
import 'package:clean_news_ai/data/database/database_repository.dart';
import 'package:clean_news_ai/data/dto/answer.dart';
import 'package:clean_news_ai/data/dto/article.dart';
import 'package:worker_manager/executor.dart';
import 'package:worker_manager/task.dart';

import '../models/news_article.dart';

class DomainRepository {
  Task<List<ArticleModel>> refreshingTask;

  Stream<List<ArticleModel>> refreshArticles(String theme) {
    if (refreshingTask != null) Executor().removeTask(task: refreshingTask);
    refreshingTask =
        Task<List<ArticleModel>>(function: DomainRepository._getTopArticles, bundle: theme);
    return Executor().addTask<List<ArticleModel>>(task: refreshingTask).map(
        (models) => models.map((model) => model..isSaved = isFavorite(model.article)).toList());
  }

  List<ArticleModel> getFavoriteArticles() => DatabaseRepository.hive().getFavoriteArticles();

  void addArticle(Article article) => DatabaseRepository.hive().addArticle(article);

  void removeArticle(Article article) => DatabaseRepository.hive().removeArticle(article);

  bool isFavorite(Article article) => DatabaseRepository.hive().isFavorite(article);

  static Future<List<ArticleModel>> _getTopArticles(String theme) async {
    final jsonData = await NetworkDataRepository.newsAPI().getTopArticles(category: theme);
    final answer = Answer.fromMap(json.decode(jsonData));
    return answer.articles.map((article) => ArticleModel(article: article)).toList();
  }
}
