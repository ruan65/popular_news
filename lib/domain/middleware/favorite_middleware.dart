import 'package:clean_news_ai/data/dto/article.dart';
import 'package:clean_news_ai/domain/repository/domain_repository.dart';
import 'package:clean_news_ai/domain/states/favorites_state.dart';
import 'package:clean_news_ai/domain/states/top_news_state.dart';
import 'package:osam/domain/middleware/middleware.dart';
import 'package:osam/domain/state/base_state.dart';
import 'package:osam/util/event.dart';

import '../event_enum.dart';

class FavoriteMiddleware extends Middleware {
  bool makeFavorite(Event<BaseState> event) {
    if (event.type == EventType.addFavorite) {
      final state = store.getState<TopNewsState>();
      final article = state.news[event.bundle];
      store.dispatchEvent<FavoritesState>(
          event: Event.modify(reducerCaller: (state, _) => state.addArticle(article)));
      DomainRepository().addArticle(article);
    }
    return nextEvent(true);
  }

  bool removeFavorite(Event<BaseState> event) {
    if (event.type == EventType.removeFavorite) {
      store.dispatchEvent<FavoritesState>(
          event: Event.modify(reducerCaller: (state, _) => state.removeArticle(event.bundle)));
      DomainRepository().removeArticle(event.bundle);
    }
    return nextEvent(true);
  }

  bool fetchEvents(Event<BaseState> event) {
    if (event.type == EventType.fetchFavorites) {
      final favoriteArticles = DomainRepository().getFavoriteArticles();
      store.dispatchEvent<FavoritesState>(
          event: Event.modify(
              reducerCaller: (state, _) => state.addNews(Map<String, Article>.fromIterable(
                  favoriteArticles,
                  key: (article) => article.url,
                  value: (article) => article))));
    }
    return nextEvent(true);
  }

  @override
  List<Condition> get conditions => [makeFavorite, removeFavorite, fetchEvents];
}
