import 'package:clean_news_ai/domain/models/news_article.dart';
import 'package:clean_news_ai/domain/repository/domain_repository.dart';
import 'package:clean_news_ai/domain/states/favorites_state.dart';
import 'package:clean_news_ai/domain/states/top_news_state.dart';
import 'package:osam/domain/middleware/middleware.dart';
import 'package:osam/domain/state/base_state.dart';
import 'package:osam/domain/store/store.dart';
import 'package:osam/util/event.dart';

import '../event_enum.dart';

class FavoriteMiddleware extends Middleware {
  bool makeFavorite(Store store, Event<BaseState> event) {
    if (event.type == EventType.addFavorite) {
      final state = store.getState<TopNewsState>();
      final model = state.news[event.bundle];
      store.dispatchEvent<FavoritesState>(
          event: Event.modify(reducerCaller: (state) => state.addArticle(model)));
      DomainRepository().addArticle(model.article);
    }
    return nextEvent(true);
  }

  bool removeFavorite(Store store, Event<BaseState> event) {
    if (event.type == EventType.removeFavorite) {
      final state = store.getState<TopNewsState>();
      store.dispatchEvent<FavoritesState>(
          event: Event.modify(reducerCaller: (state) => state.removeArticle(event.bundle)));
      DomainRepository().removeArticle(state.news[event.bundle].article);
    }
    return nextEvent(true);
  }

  bool fetchEvents(Store store, Event<BaseState> event) {
    if (event.type == EventType.fetchFavorites) {
      final favoriteArticles = DomainRepository().getFavoriteArticles();
      store.dispatchEvent<FavoritesState>(
          event: Event.modify(
              reducerCaller: (state) => state.addNews(Map<String, ArticleModel>.fromIterable(
                  favoriteArticles,
                  key: (model) => model.article.url,
                  value: (model) => model..isSaved = true))));
    }
    return nextEvent(true);
  }

  @override
  List<Condition> get conditions => [makeFavorite, removeFavorite, fetchEvents];
}
