import 'dart:async';

import 'package:clean_news_ai/data/dto/article.dart';
import 'package:clean_news_ai/domain/states/app_state/app_state.dart';
import 'package:osam/domain/event/event.dart';
import 'package:osam/domain/store/store.dart';
import 'package:osam/presentation/presenter.dart';

class TopNewsPresenter<S extends Store<AppState>> extends Presenter<S> {
  StreamSubscription<List<Article>> newsSub;
  StreamController<List<Article>> _broadcaster;

  Stream<List<Article>> get stream => _broadcaster.stream;
  List<Article> get initialData => store.state.topNewsState.news.values.toList();
  double get initialScrollPosition => store.state.topNewsState.scrollPosition;

  @override
  void init() {
    _broadcaster = StreamController<List<Article>>.broadcast();
    newsSub = store.state.topNewsState
        .propertyStream<List<Article>>((state) => state.news.values.toList())
        .listen((data) {
      _broadcaster.sink.add(data);
    });
  }

  void updateScrollPosition(double value) => store.dispatchEvent(
      event: Event.modify(reducer: (state, _) => state.topNewsState..updateScrollPosition(value)));

  @override
  void dispose() {
    newsSub.cancel();
    _broadcaster.close();
  }
}
