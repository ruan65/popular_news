import 'package:clean_news_ai/data/dto/article.dart';
import 'package:hive/hive.dart';
import 'package:osam/domain/state/base_state.dart';

part 'top_news_state.g.dart';

@HiveType()
// ignore: must_be_immutable
class TopNewsState extends BaseState<TopNewsState> {
  @HiveField(0)
  var news = <String, Map<String, Article>>{};

  @HiveField(1)
  var scrollPosition = 0.0;

  void addNews({String theme, Map<String, Article> news}) => this.news[theme] = news;

  void updateScrollPosition(double value) => scrollPosition = value;

  void cleanNews() => this.news.clear();

  @override
  List<Object> get props => [news];
}
