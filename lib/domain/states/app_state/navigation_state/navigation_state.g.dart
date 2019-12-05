// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'navigation_state.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NavigationStateAdapter extends TypeAdapter<NavigationState> {
  @override
  NavigationState read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NavigationState()
      ..navigationIndex = fields[0] as int
      ..refreshHashcode();
  }

  @override
  void write(BinaryWriter writer, NavigationState obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.navigationIndex);
  }
}
