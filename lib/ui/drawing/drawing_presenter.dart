import 'dart:async';
import 'dart:ui';

import 'package:clean_news_ai/domain/components/app/state/app_state.dart';
import 'package:osam/domain/store/store.dart';
import 'package:osam/presentation/presenter.dart';

class DrawingPresenter extends Presenter<Store<AppState>> {
  StreamSubscription<Color> colorSub;
  StreamController<Color> _broadcaster;

  Stream<Color> get stream => _broadcaster.stream;

  Color get initialData => store.state.settingsState.color;

  @override
  void init() {
    _broadcaster = StreamController<Color>.broadcast();
    colorSub = store.state.settingsState.propertyStream((state) => state.color).listen((color) {
      _broadcaster.add(color);
    });
  }

  @override
  void dispose() {
    colorSub.cancel();
    _broadcaster.close();
  }
}
