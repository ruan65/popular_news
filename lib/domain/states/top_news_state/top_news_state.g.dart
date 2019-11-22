// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'top_news_state.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TopNewsStateAdapter extends TypeAdapter<TopNewsState> {
  @override
  TopNewsState read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TopNewsState()
      ..news = (fields[0] as Map)?.cast<String, Article>()
      ..scrollPosition = fields[1] as double
      ..refreshHashcode();
  }

  @override
  void write(BinaryWriter writer, TopNewsState obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.news)
      ..writeByte(1)
      ..write(obj.scrollPosition);
  }
}
