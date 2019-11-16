import 'dart:async';

import 'package:clean_news_ai/data/dto/article.dart';
import 'package:clean_news_ai/domain/states/app_state.dart';
import 'package:osam/osam.dart';

class NewsCardPresenter<S extends Store<AppState>> extends Presenter<S> {
  final String cardId;

  StreamSubscription<Map<String, Article>> savedSub;
  final isSavedBroadcaster = StreamController<bool>.broadcast();

  NewsCardPresenter(this.cardId);

  bool get initialData => store.state.favoritesState.news.containsKey(cardId);
  Stream<bool> get stream => isSavedBroadcaster.stream;

  @override
  void init() {
    savedSub = store.state.favoritesState
        .propertyStream<Map<String, Article>>((state) => state.news)
        .listen((savedNews) {
      isSavedBroadcaster.sink.add(savedNews.containsKey(cardId) ? true : false);
    });
  }

  void addToFavorites() {
    final currentModel = store.state.topNewsState.news[cardId];
    store.dispatchEvent(
        event: Event.modify(reducer: (state, _) => state.favoritesState..addArticle(currentModel)));
  }

  void removeFromFavorites() {
    store.dispatchEvent(
        event: Event.modify(reducer: (state, _) => state.favoritesState..removeArticle(cardId)));
  }

  @override
  void dispose() {
    savedSub.cancel();
    isSavedBroadcaster.close();
  }
}
