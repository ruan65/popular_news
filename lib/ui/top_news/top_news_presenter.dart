import 'dart:async';

import 'package:clean_news_ai/data/dto/article.dart';
import 'package:clean_news_ai/domain/states/app_state.dart';
import 'package:osam/domain/store/store.dart';
import 'package:osam/presentation/presenter.dart';

class TopNewsPresenter<S extends Store<AppState>> extends Presenter<S> {
  StreamSubscription<List<Article>> newsSub;
  Stream<List<Article>> get stream => _broadcaster.stream;
  final _broadcaster = StreamController<List<Article>>.broadcast();
  List<Article> get initialData => store.state.topNewsState.news.values.toList();

  @override
  void init() {
    newsSub = store.state.topNewsState
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
