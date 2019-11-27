import 'package:hive/hive.dart';
import 'package:osam/domain/state/base_state.dart';

part 'settings_state.g.dart';

@HiveType()
// ignore: must_be_immutable
class SettingsState extends BaseState<SettingsState> {
  @HiveField(0)
  var themes = <String>{};

  void changeThemes(Set<String> themes) {
    this.themes.clear();
    this.themes.addAll(themes);
  }

  @override
  List<Object> get props => [themes];
}
