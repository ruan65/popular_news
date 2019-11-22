import 'package:hive/hive.dart';
import 'package:osam/domain/state/base_state.dart';

part 'settings_state.g.dart';

@HiveType()
// ignore: must_be_immutable
class SettingsState extends BaseState<SettingsState> {
  @HiveField(0)
  String theme = 'science';

  void changeTheme(String theme) => this.theme = theme;

  @override
  List<Object> get props => [theme];
}
