import 'dart:async';

import 'package:clean_news_ai/data/dto/article.dart';
import 'package:clean_news_ai/domain/states/app_state/app_state.dart';
import 'package:osam/osam.dart';

class NewsCardPresenter extends Presenter<Store<AppState>> {
  final Article article;

  StreamSubscription<Map<String, Article>> savedSub;
  StreamController<bool> isSavedBroadcaster;

  NewsCardPresenter(this.article);

  bool get initialData => store.state.favoritesState.news.containsKey(article.url);

  Stream<bool> get stream => isSavedBroadcaster.stream;

  @override
  void init() {
    isSavedBroadcaster = StreamController<bool>.broadcast();
    savedSub =
        store.state.favoritesState.propertyStream<Map<String, Article>>((state) => state.news).listen((savedNews) {
      isSavedBroadcaster.sink.add(savedNews.containsKey(article.url) ? true : false);
    });
  }

  void addToFavorites() =>
      store.dispatchEvent(event: Event.modify(reducer: (state, _) => state.favoritesState..addArticle(article)));

  void removeFromFavorites() {
    store.dispatchEvent(event: Event.modify(reducer: (state, _) => state.favoritesState..removeArticle(article.url)));
  }

  @override
  void dispose() {
    savedSub.cancel();
    isSavedBroadcaster.close();
  }
}
