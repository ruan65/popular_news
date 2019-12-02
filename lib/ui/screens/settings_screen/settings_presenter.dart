import 'package:clean_news_ai/domain/event_enum.dart';
import 'package:clean_news_ai/domain/states/app_state/app_state.dart';
import 'package:osam/domain/store/store.dart';
import 'package:osam/osam.dart';
import 'package:osam/presentation/presenter.dart';

class SettingsPresenter extends Presenter<Store<AppState>> {
  final selectedThemes = <String>{};

  @override
  void dispose() {
    store.dispatchEvent(
        event: Event.modify(reducer: (state, _) => state.topNewsState..cleanNews()));
    store.dispatchEvent(
        event: Event.modify(
            bundle: selectedThemes,
            reducer: (state, bundle) => state.settingsState..changeThemes(bundle),
            type: EventType.fetchNews));
  }

  @override
  void init() => selectedThemes.addAll(store.state.settingsState.themes);
}
