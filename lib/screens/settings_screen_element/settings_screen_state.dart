
import 'dart:async';

class SettingsScreenState {
  final broadcaster = StreamController.broadcast();
  get selectedThemes => broadcaster.stream;


  close() {
    broadcaster.close();
  }
}

final state = SettingsScreenState();