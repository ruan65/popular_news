

import 'package:clean_news_ai/data/dto/article.dart';
import 'package:hive/hive.dart';
import 'package:osam/domain/state/base_state.dart';

part 'favorites_state.g.dart';

@HiveType()
// ignore: must_be_immutable
class FavoritesState extends BaseState<FavoritesState> {
  @HiveField(0)
  var news = <String, Article>{};

  @HiveField(1)
  var scrollPosition = 0.0;

  void updateScrollPosition(double value) => scrollPosition = value;

  void addNews(Map<String, Article> news) => this.news.addAll(news);

  void addArticle(Article article) => this.news[article.url] = article;

  void removeArticle(String key) => this.news.remove(key);

  @override
  List<Object> get props => [news];
}
