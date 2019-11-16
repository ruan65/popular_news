import 'dart:async';

import 'package:clean_news_ai/data/dto/article.dart';
import 'package:clean_news_ai/domain/states/app_state.dart';
import 'package:osam/osam.dart';

class TopNewsPresenter<S extends Store<AppState>> extends Presenter<S> {
  StreamSubscription<List<Article>> newsSub;
  final newsBroadcaster = StreamController<List<Article>>.broadcast();

  List<Article> get initialData => store.state.topNewsState.news.values.toList();
  Stream<List<Article>> get stream => newsBroadcaster.stream;

  @override
  void init() {
    newsSub = store.state.topNewsState
        .propertyStream<List<Article>>((state) => state.news.values.toList())
        .listen((newsMap) {
      newsBroadcaster.sink.add(newsMap);
    });
  }

  @override
  void dispose() {
    newsSub.cancel();
    newsBroadcaster.close();
  }
}
