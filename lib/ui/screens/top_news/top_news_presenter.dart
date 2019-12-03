import 'dart:async';

import 'package:clean_news_ai/data/dto/article.dart';
import 'package:clean_news_ai/domain/states/app_state/app_state.dart';
import 'package:osam/domain/event/event.dart';
import 'package:osam/domain/store/store.dart';
import 'package:osam/presentation/presenter.dart';

class TopNewsPresenter extends Presenter<Store<AppState>> {
  StreamSubscription<Map<String, Map<String, Article>>> newsSub;
  StreamController<Map<String, Map<String, Article>>> _broadcaster;

  Stream<Map<String, Map<String, Article>>> get stream => _broadcaster.stream;
  Map<String, Map<String, Article>> get initialData => store.state.topNewsState.news;
  double get initialScrollPosition => store.state.topNewsState.scrollPosition;

  @override
  void init() {
    _broadcaster = StreamController<Map<String, Map<String, Article>>>.broadcast();
    newsSub = store.state.topNewsState
        .propertyStream<Map<String, Map<String, Article>>>((state) => state.news)
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
