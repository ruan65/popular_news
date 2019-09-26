import 'package:flutter/foundation.dart';

class Source {
  final String id;
  final String name;

  Source({
    @required this.id,
    @required this.name,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Source && runtimeType == other.runtimeType && id == other.id && name == other.name);

  @override
  int get hashCode => id.hashCode ^ name.hashCode;

  @override
  String toString() {
    return 'Source{' + ' id: $id,' + ' name: $name,' + '}';
  }

  Source copyWith({
    String id,
    String name,
  }) {
    return Source(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, Object> toMap() {
    return {
      'id': this.id,
      'name': this.name,
    };
  }

  factory Source.fromMap(Map<String, dynamic> map) {
    return Source(
      id: map['id'] as String,
      name: map['name'] as String,
    );
  }
}
