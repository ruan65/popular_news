import 'package:osam/domain/middleware/middleware.dart';

class FavoriteMiddleware extends Middleware {
//  bool makeFavorite(Event<BaseState> event) {
//    if (event.type == EventType.addFavorite) {
//      final state = store.getState<TopNewsState>();
//      final article = state.news[event.bundle];
//
//      store.dispatchEvent<FavoritesState>(
//          event: Event.modify(reducerCaller: (state, _) => state.addArticle(article)));
//      DomainRepository().addArticle(article.article);
//    }
//    return nextEvent(true);
//  }
//
//  bool removeFavorite(Event<BaseState> event) {
//    if (event.type == EventType.removeFavorite) {
//      final state = store.getState<TopNewsState>();
//
//      final article = state.news[event.bundle];
////      article
////        ..changeIsSaved(false)
////        ..update();
//      store.dispatchEvent<FavoritesState>(
//          event: Event.modify(reducerCaller: (state, _) => state.removeArticle(event.bundle)));
//      DomainRepository().removeArticle(event.bundle);
//    }
//    return nextEvent(true);
//  }
//
//  bool fetchEvents(Event<BaseState> event) {
//    if (event.type == EventType.fetchFavorites) {
//      final favoriteArticles = DomainRepository().getFavoriteArticles();
//      store.dispatchEvent<FavoritesState>(
//          event: Event.modify(
//              reducerCaller: (state, _) =>
//                  state.addNews(Map<String, ArticleModel>.fromIterable(favoriteArticles,
//                      key: (article) => article.url,
//                      value: (article) => ArticleModel()
//                        ..article = article
//                        ..isSaved = true))));
//    }
//    return nextEvent(true);
//  }

  @override
  List<Condition> get conditions => [];
}
