import 'package:shared_preferences/shared_preferences.dart';
import 'package:clean_news_ai/provider/provider.dart';
import 'settings_screen_state.dart';

class SettingsScreenMutator {
  final SettingsScreenState state;
  SettingsScreenMutator(this.state);

  getSelectedThemes() async {
    final themes = (await provider.prefs).getStringList("themes");
    if(themes == null) (await provider.prefs).setStringList("themes", []);
    state.broadcaster.add(themes ?? []);
    return themes ?? [];
  }

  changeThemes({bool isRemove, String theme})async {
    final List themes = (await provider.prefs).getStringList("themes");
    if(themes == null) (await provider.prefs).setStringList("themes", []);
    isRemove ? themes.remove(theme) : themes.add(theme);
    themes.sort();
    state.broadcaster.add(themes ?? []);
    (await provider.prefs).setStringList("themes", themes);
  }

}

final mutator = SettingsScreenMutator(state);