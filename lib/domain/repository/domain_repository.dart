import 'dart:async';
import 'dart:convert';
import 'dart:core';

import 'package:clean_news_ai/data/api/network_data_repository.dart';
import 'package:clean_news_ai/data/database/database_repository.dart';
import 'package:clean_news_ai/data/dto/answer.dart';
import 'package:clean_news_ai/data/dto/article.dart';

class DomainRepository {
  List<Article> getFavoriteArticles() => DatabaseRepository.hive().getFavoriteArticles();

  void addArticle(Article article) => DatabaseRepository.hive().addArticle(article);

  void removeArticle(String articleKey) => DatabaseRepository.hive().removeArticle(articleKey);

  bool isFavorite(Article article) => DatabaseRepository.hive().isFavorite(article);

  void changeTheme(String theme) => DatabaseRepository.hive().changeTheme(theme);

  String currentTheme() => DatabaseRepository.hive().getTheme();

  static Future<List<Article>> getTopArticles(String theme) async {
    final jsonData = await NetworkDataRepository.newsAPI().getTopArticles(category: theme);
    final answer = Answer.fromMap(json.decode(jsonData));
    return answer.articles;
  }
}
