import 'dart:async';

import 'package:clean_news_ai/data/dto/article.dart';
import 'package:clean_news_ai/domain/states/app_state/app_state.dart';
import 'package:osam/domain/store/store.dart';
import 'package:osam/presentation/presenter.dart';

class FavoritesPresenter<S extends Store<AppState>> extends Presenter<S> {
  StreamSubscription<List<Article>> newsSub;
  Stream<List<Article>> get stream => _broadcaster.stream;
  StreamController<List<Article>> _broadcaster;
  List<Article> get initialData => store.state.favoritesState.news.values.toList();

  @override
  void init() {
    _broadcaster = StreamController<List<Article>>.broadcast();
    newsSub = store.state.favoritesState
        .propertyStream<List<Article>>((state) => state.news.values.toList())
        .listen((data) {
      _broadcaster.sink.add(data);
    });
  }

  @override
  void dispose() {
    newsSub.cancel();
    _broadcaster.close();
  }
}
