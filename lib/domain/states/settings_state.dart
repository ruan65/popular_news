import 'package:osam/domain/state/base_state.dart';

// ignore: must_be_immutable
class SettingsState extends BaseState<SettingsState> {
  String theme = 'science';

  void changeTheme(String theme) => this.theme = theme;

  @override
  List<Object> get props => [theme];
}
