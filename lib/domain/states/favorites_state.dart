import 'package:clean_news_ai/data/dto/article.dart';
import 'package:osam/domain/state/base_state.dart';

// ignore: must_be_immutable
class FavoritesState extends BaseState {
  final news = <String, Article>{};

  void addNews(Map<String, Article> news) => this.news.addAll(news);

  void addArticle(Article article) => this.news[article.url] = article;

  void removeArticle(String key) => this.news.remove(key);

  @override
  Map<String, Object> get namedProps => {'news': news};
}
