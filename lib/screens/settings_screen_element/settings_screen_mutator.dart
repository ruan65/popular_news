import 'package:shared_preferences/shared_preferences.dart';
import 'settings_screen_state.dart';

class SettingsScreenMutator {
  final SettingsScreenState state;
  final _prefs = SharedPreferences.getInstance();
  SettingsScreenMutator(this.state);

  getSelectedThemes() async {
    final themes = (await _prefs).getStringList("themes");
    if(themes == null) (await _prefs).setStringList("themes", []);
    state.broadcaster.add(themes);
    return themes;
  }

  addTheme(theme) async {
    final themes = (await _prefs).getStringList("themes");
    themes.add(theme);
    state.broadcaster.add(themes);
    (await _prefs).setStringList("themes", themes);
  }

  deleteTheme(theme) async {
    final themes = (await _prefs).getStringList("themes");
    themes.remove(theme);
    state.broadcaster.add(themes);
    (await _prefs).setStringList("themes", themes);
  }

}

final mutator = SettingsScreenMutator(state);