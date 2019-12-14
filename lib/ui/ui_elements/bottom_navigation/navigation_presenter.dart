import 'dart:async';

import 'package:clean_news_ai/domain/components/app/state/app_state.dart';
import 'package:osam/domain/store/store.dart';
import 'package:osam/osam.dart';
import 'package:osam/presentation/presenter.dart';

class NavigationPresenter<S extends Store<AppState>> extends Presenter<S> {
  StreamSubscription<int> navigationIndexSub;

  Stream<int> get stream => _broadcaster.stream;
  StreamController<int> _broadcaster;

  int get initialData => store.state.navigationState.navigationIndex;

  @override
  void init() {
    _broadcaster = StreamController<int>.broadcast();

    navigationIndexSub =
        store.state.navigationState.propertyStream<int>((state) => state.navigationIndex).listen((data) {
      _broadcaster.sink.add(data);
    });
  }

  void routeTo(int index) {
    store.dispatchEvent(event: Event.modify(reducer: (state, _) => state.navigationState..routeTo(index)));
  }

  void refreshNavigationIndex(int index) => store.state.navigationState
    ..navigationIndex = index
    ..refreshHashcode();

  @override
  void dispose() {
    navigationIndexSub.cancel();
    _broadcaster.close();
  }
}
