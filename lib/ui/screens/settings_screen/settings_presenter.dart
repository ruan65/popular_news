import 'dart:async';
import 'package:clean_news_ai/domain/event_enum.dart';
import 'package:clean_news_ai/domain/states/app_state/app_state.dart';
import 'package:osam/domain/store/store.dart';
import 'package:osam/osam.dart';
import 'package:osam/presentation/presenter.dart';

class SettingsPresenter extends Presenter<Store<AppState>> {
  StreamSubscription<Set<String>> selectedThemesSub;

  Stream<Set<String>> get themesStream => _themesBroadcaster.stream;
  StreamController<Set<String>> _themesBroadcaster;

  Set<String> get initialData => store.state.settingsState.themes;

  @override
  void init() {
    _themesBroadcaster = StreamController<Set<String>>.broadcast();
    selectedThemesSub = store.state.settingsState.propertyStream<Set<String>>((state) => state.themes).listen((data) {
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

  @override
  void dispose() {
    selectedThemesSub.cancel();
    _themesBroadcaster.close();
    store.dispatchEvent(event: Event.sideEffect(type: EventType.fetchNews));
  }
}
