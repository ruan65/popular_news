import 'package:clean_news_ai/domain/models/news_article.dart';
import 'package:hive/hive.dart';

import '../dto/article.dart';

abstract class DatabaseRepository {
  Future<void> init();

  List<ArticleModel> getFavoriteArticles();

  void addArticle(Article article);

  void removeArticle(Article article);

  bool isFavorite(Article article);

  factory DatabaseRepository.hive() => _HiveDatabaseRepository();
}

class _HiveDatabaseRepository implements DatabaseRepository {
  Box _box;

  static final _HiveDatabaseRepository _repositoryImpl = _HiveDatabaseRepository._internal();

  factory _HiveDatabaseRepository() => _repositoryImpl;

  _HiveDatabaseRepository._internal();

  Future<void> init() async => _box = await Hive.openBox('favorites');

  List<ArticleModel> getFavoriteArticles() =>
      _box.values.map((value) => ArticleModel(article: value as Article)..isSaved = true).toList();

  void addArticle(Article article) => _box.put(article.url, article);

  void removeArticle(Article article) => _box.delete(article.url);

  bool isFavorite(Article article) => _box.containsKey(article.url);
}
