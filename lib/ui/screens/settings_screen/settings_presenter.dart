import 'dart:async';
import 'dart:ui';

import 'package:clean_news_ai/domain/components/app/state/app_state.dart';
import 'package:clean_news_ai/domain/components/top_news/events/top_news_events.dart';
import 'package:osam/domain/store/store.dart';
import 'package:osam/osam.dart';
import 'package:osam/presentation/presenter.dart';

class SettingsPresenter extends Presenter<Store<AppState>> {
  StreamSubscription<List<String>> selectedThemesSub;
  StreamController<List<String>> _themesBroadcaster;

  Stream<List<String>> get themesStream => _themesBroadcaster.stream;

  List<String> get initialData => store.state.settingsState.themes;

  @override
  void init() {
    _themesBroadcaster = StreamController<List<String>>.broadcast();
    selectedThemesSub = store.state.settingsState.propertyStream<List<String>>((state) => state.themes).listen((data) {
      _themesBroadcaster.sink.add(data);
    });
  }

  void changeThemesForTopNewsState() => store.dispatchEvent(
      event: Event.modify(reducer: (state, _) => state.topNewsState..clearAndAddNewThemes(initialData)));

  void addTheme(String theme) {
    store.dispatchEvent(event: Event.modify(reducer: (state, _) => state.settingsState..addTheme(theme)));
    changeThemesForTopNewsState();
  }

  void removeTheme(String theme) {
    store.dispatchEvent(event: Event.modify(reducer: (state, _) => state.settingsState..removeTheme(theme)));
    changeThemesForTopNewsState();
  }

  void changeColor(Color color) =>
      store.dispatchEvent(event: Event.modify(reducer: (state, _) => state.settingsState..changeColor(color)));

  @override
  void dispose() {
    selectedThemesSub.cancel();
    _themesBroadcaster.close();
    store.dispatchEvent(event: FetchNewsEvent());
  }
}
