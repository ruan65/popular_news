// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_state.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppStateAdapter extends TypeAdapter<AppState> {
  @override
  AppState read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppState()
      ..topNewsState = fields[0] as TopNewsState
      ..navigationState = fields[1] as NavigationState
      ..favoritesState = fields[2] as FavoritesState
      ..settingsState = fields[3] as SettingsState
      ..refreshHashcode();
  }

  @override
  void write(BinaryWriter writer, AppState obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.topNewsState)
      ..writeByte(1)
      ..write(obj.navigationState)
      ..writeByte(2)
      ..write(obj.favoritesState)
      ..writeByte(3)
      ..write(obj.settingsState);
  }
}
