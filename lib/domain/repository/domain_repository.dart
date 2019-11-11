import 'dart:async';
import 'dart:convert';
import 'dart:core';

import 'package:clean_news_ai/data/api/network_data_repository.dart';
import 'package:clean_news_ai/data/database/database_repository.dart';
import 'package:clean_news_ai/data/dto/answer.dart';
import 'package:clean_news_ai/data/dto/article.dart';
import 'package:worker_manager/task.dart';

import '../models/news_article.dart';

class DomainRepository {
  Task<List<ArticleModel>> refreshingTask;

  List<ArticleModel> getFavoriteArticles() => DatabaseRepository.hive().getFavoriteArticles();

  void addArticle(Article article) => DatabaseRepository.hive().addArticle(article);

  void removeArticle(Article article) => DatabaseRepository.hive().removeArticle(article);

  bool isFavorite(Article article) => DatabaseRepository.hive().isFavorite(article);

  static Future<List<ArticleModel>> getTopArticles(String theme) async {
    final jsonData = await NetworkDataRepository.newsAPI().getTopArticles(category: theme);
    final answer = Answer.fromMap(json.decode(jsonData));
    return answer.articles.map((article) => ArticleModel(article: article)).toList();
  }
}
