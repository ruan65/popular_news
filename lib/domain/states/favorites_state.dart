import 'package:clean_news_ai/domain/models/news_article.dart';
import 'package:osam/domain/state/base_state.dart';

// ignore: must_be_immutable
class FavoritesState extends BaseState {
  final news = <String, ArticleModel>{};

  void addNews(Map<String, ArticleModel> news) => this.news.addAll(news);

  void addArticle(ArticleModel model) => this.news[model.article.url] = model;

  void removeArticle(String key) => this.news.remove(key);

  @override
  Map<String, Object> get namedProps => {'news': news};
}
