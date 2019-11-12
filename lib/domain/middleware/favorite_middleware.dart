import 'package:clean_news_ai/domain/models/news_article.dart';
import 'package:clean_news_ai/domain/repository/domain_repository.dart';
import 'package:clean_news_ai/domain/states/favorites_state.dart';
import 'package:clean_news_ai/domain/states/top_news_state.dart';
import 'package:osam/domain/middleware/middleware.dart';
import 'package:osam/domain/state/base_state.dart';
import 'package:osam/util/event.dart';

import '../event_enum.dart';

class FavoriteMiddleware extends Middleware {
  bool markAsFavorite(Event<BaseState> event) {
    if (event.type == EventType.setNews) {
      (event.bundle as Map<String, ArticleModel>)
          .values
          .forEach((model) => model..isSaved = DomainRepository().isFavorite(model.article));
    }

    return nextEvent(true);
  }

  bool makeFavorite(Event<BaseState> event) {
    if (event.type == EventType.addFavorite) {
      final state = store.getState<TopNewsState>();
      final model = state.news[event.bundle];
      store.dispatchEvent<FavoritesState>(
          event: Event.modify(reducerCaller: (state, _) => state.addArticle(model)));
      DomainRepository().addArticle(model.article);
    }
    return nextEvent(true);
  }

  bool removeFavorite(Event<BaseState> event) {
    if (event.type == EventType.removeFavorite) {
      final state = store.getState<TopNewsState>();
      store.dispatchEvent<FavoritesState>(
          event: Event.modify(reducerCaller: (state, _) => state.removeArticle(event.bundle)));
      DomainRepository().removeArticle(state.news[event.bundle].article);
    }
    return nextEvent(true);
  }

  bool fetchEvents(Event<BaseState> event) {
    if (event.type == EventType.fetchFavorites) {
      final favoriteArticles = DomainRepository().getFavoriteArticles();
      store.dispatchEvent<FavoritesState>(
          event: Event.modify(
              reducerCaller: (state, _) => state.addNews(Map<String, ArticleModel>.fromIterable(
                  favoriteArticles,
                  key: (model) => model.article.url,
                  value: (model) => model..isSaved = true))));
    }
    return nextEvent(true);
  }

  @override
  List<Condition> get conditions => [markAsFavorite, makeFavorite, removeFavorite, fetchEvents];
}
