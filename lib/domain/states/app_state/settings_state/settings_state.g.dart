// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_state.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SettingsStateAdapter extends TypeAdapter<SettingsState> {
  @override
  SettingsState read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SettingsState()
      ..themes = (fields[0] as Set)?.cast<String>()
      ..refreshHashcode();
  }

  @override
  void write(BinaryWriter writer, SettingsState obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.themes?.toList());
  }
}
