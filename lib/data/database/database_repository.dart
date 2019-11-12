import 'package:hive/hive.dart';

import '../dto/article.dart';

const settingsKey = 'settings';

abstract class DatabaseRepository {
  Future<void> init();

  List<Article> getFavoriteArticles();

  void addArticle(Article article);

  void removeArticle(String articleKey);

  bool isFavorite(Article article);

  void changeTheme(String theme);

  String getTheme();

  factory DatabaseRepository.hive() => _HiveDatabaseRepository();
}

class _HiveDatabaseRepository implements DatabaseRepository {
  Box<Article> _favoritesBox;
  Box _settingsBox;

  static final _HiveDatabaseRepository _repositoryImpl = _HiveDatabaseRepository._internal();

  factory _HiveDatabaseRepository() => _repositoryImpl;

  _HiveDatabaseRepository._internal();

  @override
  Future<void> init() async {
    _favoritesBox = await Hive.openBox('favorites');
    _settingsBox = await Hive.openBox('settings');
  }

  @override
  List<Article> getFavoriteArticles() => _favoritesBox.values.toList();

  @override
  void addArticle(Article article) => _favoritesBox.put(article.url, article);

  @override
  void removeArticle(String articleKey) => _favoritesBox.delete(articleKey);

  @override
  bool isFavorite(Article article) => _favoritesBox.containsKey(article.url);

  //todo: list of themes

  @override
  String getTheme() => _settingsBox.get(settingsKey, defaultValue: 'science');

  @override
  void changeTheme(String theme) => _settingsBox.put(settingsKey, theme);
}
